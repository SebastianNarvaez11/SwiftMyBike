//
//  LoginDataRequest.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 6/11/24.
//

import Foundation

struct LoginBodyRequest : Encodable {
    let email: String
    let password: String
}
