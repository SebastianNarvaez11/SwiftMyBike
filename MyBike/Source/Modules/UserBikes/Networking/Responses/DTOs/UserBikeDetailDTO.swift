//
//  UserBikeDetailDTO.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 22/12/24.
//

import Foundation

struct UserBikeDetailDTO {
    let id: String
    let nickname: String?
    let mileage: String?
    let nextOilChangeDate: String?
    let userId: String
    let gpsId: String?
    let bike: BikeDTO
}

extension UserBikeDetailDTO: Decodable {
    enum CodingKeys: String, CodingKey{
        case id, nickname, mileage, bike
        case nextOilChangeDate = "next_oil_change_date"
        case gpsId = "gps_id"
        case userId = "user_id"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.nickname = try container.decodeIfPresent(String.self, forKey: .nickname)
        self.mileage = try container.decodeIfPresent(String.self, forKey: .mileage)
        self.nextOilChangeDate = try container.decodeIfPresent(String.self, forKey: .nextOilChangeDate)
        self.gpsId = try container.decodeIfPresent(String.self, forKey: .gpsId)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.bike = try container.decode(BikeDTO.self, forKey: .bike)
    }
}
