//
//  GetSignedUrlResponse.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 14/12/24.
//

import Foundation

struct GetSignedUrlResponse {
    let signedURL: String
}

extension GetSignedUrlResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case signedURL
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.signedURL = try container.decode(String.self, forKey: .signedURL)
    }
}
