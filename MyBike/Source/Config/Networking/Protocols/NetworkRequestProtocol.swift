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
    func execute(method: String, body: Encodable?, hasToken: Bool, hasApiKey: Bool) async throws -> ResponseType
}

extension NetworkRequestProtocol {
    func sendRequest(url: URL, method: String, body: Encodable?, hasToken: Bool, hasApiKey: Bool) async throws -> ResponseType {
        let tokenManager = TokenManager()
        
        var request = URLRequest(url:url)
        request.httpMethod = method
        
        if let body = body {
            do {
                request.httpBody = try JSONEncoder().encode(body)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                throw APIError.encodingError
            }
        }
        
        if hasToken, let token = tokenManager.accessToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if hasApiKey {
            let apiKey = ApiConfig.apiKeySupabase
            request.setValue(apiKey, forHTTPHeaderField: "apikey")
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.unknownError
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return try self.decode(data: data)
        case 401:
            do{
                try await tokenManager.refreshAccessToken()
                print("reintentando la peticion...")
                return try await self.sendRequest(url: url, method: method, body: body, hasToken: hasToken, hasApiKey: hasApiKey)
            } catch {
                throw APIError.unauthorized
            }
        default:
            if let error = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                throw APIError.serverError(message: error.msg)
            }else{
                print("aqui")
                throw APIError.decodingError
            }
        }
    }
}
