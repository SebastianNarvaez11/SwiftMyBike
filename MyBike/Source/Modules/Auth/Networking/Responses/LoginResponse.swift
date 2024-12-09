//
//  LoginResponse.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 6/11/24.
//

import Foundation

struct LoginResponse {
    let accessToken, refreshToken: String
    let expiresIn, expiresAt: Int
    let user: UserLoginDTO
}

extension LoginResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
        case expiresAt = "expires_at"
        case user
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.accessToken = try container.decode(String.self, forKey: .accessToken)
        self.refreshToken = try container.decode(String.self, forKey: .refreshToken)
        self.expiresIn = try container.decode(Int.self, forKey: .expiresIn)
        self.expiresAt = try container.decode(Int.self, forKey: .expiresAt)
        self.user = try container.decode(UserLoginDTO.self, forKey: .user)
    }
}
