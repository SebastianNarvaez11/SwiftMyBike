//
//  ErrorResponse.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 6/11/24.
//

import Foundation

struct ErrorResponse: Decodable {
    let msg: String
    let code: Int
}
