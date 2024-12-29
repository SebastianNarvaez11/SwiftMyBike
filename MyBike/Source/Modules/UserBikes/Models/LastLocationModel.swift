//
//  LastLocationModel.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 25/12/24.
//

import Foundation

struct LastLocationModel: Hashable, Identifiable {
    let id: UUID = UUID()
    let latitude: Double
    let longitude: Double
    let speed: Double
    let inactiveSeconds: Double
    let mileage: Double
}

extension LastLocationModel {
    init(fromDto locationDTO: LastLocationDTO) {
        self.latitude = locationDTO.latitude
        self.longitude = locationDTO.longitude
        self.speed = locationDTO.speed
        self.mileage = locationDTO.milleage
        self.inactiveSeconds = locationDTO.inactiveSeconds
    }
}
