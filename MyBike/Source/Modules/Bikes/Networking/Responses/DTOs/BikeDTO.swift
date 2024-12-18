//
//  BikeDTO.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 17/12/24.
//

import Foundation

struct BikeDTO {
    let id: String
    let model: String
    let year: Int
    let photo1: String?
    let photo2: String?
    let photo3: String?
    let brand: BrandDTO
}

extension BikeDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case id, model, year, brand
        case photo1 = "photo_1"
        case photo2 = "photo_2"
        case photo3 = "photo_3"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.model = try container.decode(String.self, forKey: .model)
        self.year = try container.decode(Int.self, forKey: .year)
        self.brand = try container.decode(BrandDTO.self, forKey: .brand)
        self.photo1 = try container.decodeIfPresent(String.self, forKey: .photo1)
        self.photo2 = try container.decodeIfPresent(String.self, forKey: .photo2)
        self.photo3 = try container.decodeIfPresent(String.self, forKey: .photo3)
    }
}
