//
//  RegisterResponse.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 6/11/24.
//

import Foundation

struct RegisterResponse {
    let id, email: String
}

extension RegisterResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case id, email
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.email = try container.decode(String.self, forKey: .email)
    }
}
