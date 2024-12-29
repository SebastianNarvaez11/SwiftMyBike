//
//  LoginPlaspyResponse.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 25/12/24.
//

import Foundation

struct LoginPlaspyResponse {
    let token:String
}

extension LoginPlaspyResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case token
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.token = try container.decode(String.self, forKey: .token)
    }
}
