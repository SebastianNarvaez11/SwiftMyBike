//
//  RefreshTokenBodyRequest.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 6/11/24.
//

import Foundation

struct RefreshTokenBodyRequest : Encodable {
    let refreshToken: String
}

extension RefreshTokenBodyRequest {
    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(refreshToken, forKey: .refreshToken)
    }
}
