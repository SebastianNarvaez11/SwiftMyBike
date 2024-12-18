//
//  RegisterBodyRequest.swift
//  MyBike
//
//  Created by Sebastian on 3/09/24.
//

import Foundation

struct RegisterBodyRequest : Encodable {
    let email: String
    let password: String
}
