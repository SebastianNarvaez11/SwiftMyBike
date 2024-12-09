//
//  CheckStatusResponse.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 6/11/24.
//

import Foundation

struct CheckStatusResponse {
    let user: UserLoginDTO
}

extension CheckStatusResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case user
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.user = try container.decode(UserLoginDTO.self, forKey: .user)
    }
}
