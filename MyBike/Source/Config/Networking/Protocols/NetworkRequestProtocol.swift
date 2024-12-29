//
//  NetworkRequestProtocol.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 6/11/24.
//

import Foundation

protocol NetworkRequestProtocol: AnyObject {
    associatedtype ResponseType
    func decode(data: Data) throws -> ResponseType
    func execute(method: String, body: Encodable?, hasToken: Bool, token: String?, hasApiKey: Bool, imageData: UploadImageRequest?) async throws -> ResponseType
}

extension NetworkRequestProtocol {
    func sendRequest(url: URL, method: String, body: Encodable?, hasToken: Bool, token: String?, hasApiKey: Bool, imageData: UploadImageRequest?) async throws -> ResponseType {
        let tokenManager = TokenManager()
        
        var request = URLRequest(url:url)
        request.httpMethod = method
        
        if let body = body {
            do {
                request.httpBody = try JSONEncoder().encode(body)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.setValue("return=representation", forHTTPHeaderField: "Prefer")
            } catch {
                throw APIError.encodingError
            }
        }
        
        if hasToken {
            if let token = token {
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            } else {
                if let accessToken = tokenManager.accessToken {
                    request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
                }
            }
        }
        
        if hasApiKey {
            let apiKey = ApiConfig.apiKeySupabase
            request.setValue(apiKey, forHTTPHeaderField: "apikey")
        }
        
        if let imageData = imageData {
            let boundary = "Boundary-\(UUID().uuidString)"
            request.addValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            var data = Data()
            
            data.append("--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"\(imageData.userId)\"; filename=\"\(imageData.userId).\(imageData.image.ext)\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: image/\(imageData.image.ext)\r\n\r\n".data(using: .utf8)!)
            data.append(imageData.image.data)
            data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
            request.httpBody = data
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.unknownError
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return try self.decode(data: data)
        case 401, 403:
            do{
                try await tokenManager.refreshAccessToken()
                print("reintentando la peticion...")
                return try await self.sendRequest(url: url, method: method, body: body, hasToken: hasToken, token: token, hasApiKey: hasApiKey, imageData: imageData)
            } catch {
                throw APIError.unauthorized
            }
        default:
            if let error = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                throw APIError.serverError(message: error.msg)
                
            } else if let errorMessage = String(data: data, encoding: .utf8) {
                print("Mensaje de error: \(errorMessage)")
                throw APIError.serverError(message: errorMessage)
                
            } else {
                print("Error desconocido")
                throw APIError.unknownError
            }
        }
    }
}
