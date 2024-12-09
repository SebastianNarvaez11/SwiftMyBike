//
//  SchoolModel.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 6/11/24.
//

import Foundation

struct SchoolModel {
    let id: String
    let name: String
    let image: String
}

extension SchoolModel: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image = "logo"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try container.decode(String.self, forKey: .image)
    }
}
