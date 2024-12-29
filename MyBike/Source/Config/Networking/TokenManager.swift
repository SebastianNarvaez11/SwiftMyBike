//
//  TokenManager.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 7/11/24.
//

import Foundation
import KeychainSwift

class TokenManager: TokenManagerProtocol {
    private let keychain = KeychainSwift()
    
    var accessToken: String? {
        return keychain.get("ACCESS-TOKEN-MB")
    }
    
    var refreshToken: String? {
        return keychain.get("REFRESH-TOKEN-MB")
    }
    
    var accessTokenPlaspy: String? {
        return keychain.get("ACCESS-TOKEN-PLASPY")
    }
    
    func saveTokens(accessToken: String, refreshToken: String) {
        keychain.set(accessToken, forKey: "ACCESS-TOKEN-MB")
        keychain.set(refreshToken, forKey: "REFRESH-TOKEN-MB")
    }
    
    func savePlaspyToken(token: String) {
        keychain.set(token, forKey:"ACCESS-TOKEN-PLASPY")
    }
    
    func removeTokens() {
        keychain.delete("ACCESS-TOKEN-MB")
        keychain.delete("REFRESH-TOKEN-MB")
        keychain.delete("ACCESS-TOKEN-PLASPY")
    }
    
    func refreshAccessToken() async throws -> Void {
        guard let refreshToken = self.refreshToken else {
            throw APIError.unauthorized
        }
        
        print("obteniendo nuevo access token...")
        
        var request = URLRequest(url: RefreshTokenResource().url)
        
        request.httpMethod = "POST"
        let apiKey = ApiConfig.apiKeySupabase
        request.setValue(apiKey, forHTTPHeaderField: "apikey")
        request.httpBody = try JSONEncoder().encode(RefreshTokenBodyRequest(refreshToken: refreshToken))
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
            print(data)
            throw APIError.unauthorized
        }
        
        let tokenResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
        keychain.set(tokenResponse.accessToken, forKey: "ACCESS-TOKEN-MB")
    }
}

