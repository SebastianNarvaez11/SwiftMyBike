//
//  LastLocationDTO.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 25/12/24.
//

import Foundation

struct LastLocationDTO {
    let latitude: Double
    let longitude: Double
    let speed: Double
    let inactiveSeconds: Double
    let milleage: Double
}

extension LastLocationDTO: Decodable{
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case speed
        case inactiveSeconds
        case milleage
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        self.speed = try container.decode(Double.self, forKey: .speed)
        self.inactiveSeconds = try container.decode(Double.self, forKey: .inactiveSeconds)
        self.milleage = try container.decode(Double.self, forKey: .milleage)
    }
}
