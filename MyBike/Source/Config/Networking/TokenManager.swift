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
        return keychain.get("ACCESS-TOKEN-SP")
    }
    
    var refreshToken: String? {
        return keychain.get("REFRESH-TOKEN-SP")
    }
    
    func saveTokens(accessToken: String, refreshToken: String) {
        keychain.set(accessToken, forKey: "ACCESS-TOKEN-SP")
        keychain.set(refreshToken, forKey: "REFRESH-TOKEN-SP")
    }
    
    func removeTokens() {
        keychain.delete("ACCESS-TOKEN-SP")
        keychain.delete("REFRESH-TOKEN-SP")
    }
    
    func refreshAccessToken() async throws -> Void {
        guard let refreshToken = self.refreshToken else {
            throw APIError.unauthorized
        }
        
        print("obteniendo nuevo access token...")
        
        var request = URLRequest(url: RefreshTokenResource().url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
            print(data)
            throw APIError.unauthorized
        }
        
        let tokenResponse = try JSONDecoder().decode(RefreshTokenResponse.self, from: data)
        keychain.set(tokenResponse.newAccessToken, forKey: "ACCESS-TOKEN-SP")
    }
}

