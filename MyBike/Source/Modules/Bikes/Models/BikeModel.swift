//
//  BikeModel.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 17/12/24.
//

import Foundation

struct BikeModel: Identifiable, Hashable {
    let id: String
    let model: String
    let year: Int
    let photo1: String?
    let photo2: String?
    let photo3: String?
    let brand: BrandModel
}

extension BikeModel {
    init(fromDTO bikeDto: BikeDTO) {
        self.id = bikeDto.id
        self.brand = BrandModel(id: bikeDto.brand.id, name: bikeDto.brand.name)
        self.model = bikeDto.model
        self.year = bikeDto.year
        self.photo1 = bikeDto.photo1
        self.photo2 = bikeDto.photo2
        self.photo3 = bikeDto.photo3
    }
}
