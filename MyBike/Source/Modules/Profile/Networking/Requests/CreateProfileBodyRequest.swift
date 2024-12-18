//
//  CreateProfileBodyRequest.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 6/11/24.
//

import Foundation

struct CreateProfileBodyRequest : Encodable {
    let name: String
    let userId: String
    let image: String?
}

extension CreateProfileBodyRequest {
    enum CodingKeys: String, CodingKey {
        case name, image
        case userId = "user_id"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(image, forKey: .image)
        try container.encode(userId, forKey: .userId)
    }
}
