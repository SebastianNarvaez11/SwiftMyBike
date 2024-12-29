//
//  UserBikeModel.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 22/12/24.
//

import Foundation

struct UserBikeModel: Identifiable, Hashable {
    let id: String
    let nickname: String?
    let mileage: String?
    let nextOilChangeDate: Date?
    let bike: BikeModel
    let gpsId: String?
}

extension UserBikeModel {
    init(fromDTO userBikeDto: UserBikeDetailDTO, signedUrl: String? = nil) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        var date: Date?
        
        if let nextOilChangeDate = userBikeDto.nextOilChangeDate {
             date = dateFormatter.date(from: nextOilChangeDate)
        }
        
        self.id = userBikeDto.id
        self.nickname = userBikeDto.nickname
        self.mileage = userBikeDto.mileage
        self.nextOilChangeDate = date
        self.bike = BikeModel(fromDTO: userBikeDto.bike, signedUrl: signedUrl)
        self.gpsId = userBikeDto.gpsId
    }
}
