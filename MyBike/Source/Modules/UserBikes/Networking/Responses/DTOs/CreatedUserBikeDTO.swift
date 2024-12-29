//
//  CreatedUserBikeDTO.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 21/12/24.
//

import Foundation

struct CreatedUserBikeDTO: Decodable {
    let id: String
    let nickname: String?
    let mileage: String?
    let nextOilChangeDate: String?
    let bikeId: String
    let userId: String
}

extension CreatedUserBikeDTO {
    enum CodingKeys: String, CodingKey {
        case id, nickname, mileage
        case nextOilChangeDate = "next_oil_change_date"
        case bikeId = "bike_id"
        case userId = "user_id"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.nickname = try container.decodeIfPresent(String.self, forKey: .nickname)
        self.mileage = try container.decodeIfPresent(String.self, forKey: .mileage)
        self.nextOilChangeDate = try container.decodeIfPresent(String.self, forKey: .nextOilChangeDate)
        self.bikeId = try container.decode(String.self, forKey: .bikeId)
        self.userId = try container.decode(String.self, forKey: .userId)
    }
}
