//
//  UserLoginDTO.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 8/12/24.
//

import Foundation

struct UserLoginDTO {
    let id: String
    let email: String
    let phone: String
    let lastSignIn: String
}

extension UserLoginDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case id, email, phone
        case lastSignIn = "last_sign_in_at"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.email = try container.decode(String.self, forKey: .email)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.lastSignIn = try container.decode(String.self, forKey: .lastSignIn)
    }
}
