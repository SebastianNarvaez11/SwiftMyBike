//
//  BrandDTO.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 17/12/24.
//

import Foundation

struct BrandDTO {
    let id: String
    let name: String
}

extension BrandDTO: Decodable {
    enum CodingKeys: String, CodingKey{
        case id, name
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
}
