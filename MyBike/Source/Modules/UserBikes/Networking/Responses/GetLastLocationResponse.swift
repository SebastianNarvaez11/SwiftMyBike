//
//  GetLastLocationResponse.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 25/12/24.
//

import Foundation

struct GetLastLocationResponse {
    let lastLocation: LastLocationDTO
}

extension GetLastLocationResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case lastLocation
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lastLocation = try container.decode(LastLocationDTO.self, forKey: .lastLocation)
    }
}
