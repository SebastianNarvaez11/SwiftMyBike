//
//  UploadImageResponse.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 14/12/24.
//

import Foundation

struct UploadImageResponse {
    let key, id: String
}

extension UploadImageResponse: Decodable {
    enum CodingKeys: String, CodingKey{
        case key = "Key"
        case id = "Id"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.key = try container.decode(String.self, forKey: .key)
        self.id = try container.decode(String.self, forKey: .id)
    }
}
