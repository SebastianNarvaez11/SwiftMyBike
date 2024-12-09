//
//  RefreshTokenResponse.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 6/11/24.
//

import Foundation

struct RefreshTokenResponse {
    let newAccessToken: String
}

extension RefreshTokenResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case newAccessToken
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.newAccessToken = try container.decode(String.self, forKey: .newAccessToken)
    }
}
