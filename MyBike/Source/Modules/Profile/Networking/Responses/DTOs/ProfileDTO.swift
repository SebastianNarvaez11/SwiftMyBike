//
//  ProfileDTO.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 10/12/24.
//

import Foundation

struct ProfileDTO {
    let id: String
    let name: String
    let userId: String
    let image: String?
}

extension ProfileDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case id, name, image
        case userId = "user_id"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.userId = try container.decode(String.self, forKey: .userId)
    }
}
