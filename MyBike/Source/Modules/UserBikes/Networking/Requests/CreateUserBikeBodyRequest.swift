//
//  CreateUserBikeBodyRequest.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 21/12/24.
//

import Foundation

struct CreateUserBikeBodyRequest: Encodable {
    let userId: String
    let bikeId: String
    let nickname: String?
    let mileage: String?
    let nextOilChangeDate: Date?
    
    init(userId: String, bikeId: String, nickname: String? = nil, mileage: String? = nil, nextOilChangeDate: Date? = nil) {
        self.userId = userId
        self.bikeId = bikeId
        self.nickname = nickname
        self.mileage = mileage
        self.nextOilChangeDate = nextOilChangeDate
    }
}

extension CreateUserBikeBodyRequest {
    enum CodingKeys: String, CodingKey {
        case nickname, mileage
        case userId = "user_id"
        case bikeId = "bike_id"
        case nextOilChangeDate = "next_oil_change_date"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userId, forKey: .userId)
        try container.encode(bikeId, forKey: .bikeId)
        try container.encode(nickname, forKey: .nickname)
        try container.encode(mileage, forKey: .mileage)
        try container.encode(nextOilChangeDate, forKey: .nextOilChangeDate)
    }
}
