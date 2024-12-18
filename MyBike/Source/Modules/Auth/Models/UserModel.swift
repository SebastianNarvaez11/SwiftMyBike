//
//  UserModel.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 6/11/24.
//

import Foundation

struct UserModel: Identifiable, Hashable  {
    let id: String
    let email: String
    let phone: String
    let lastLogin: Date
}

extension UserModel {
    init(fromDTO userDto: UserLoginDTO) {
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from: userDto.lastSignIn) ?? Date()
        
        self.id = userDto.id
        self.email = userDto.email
        self.phone = userDto.phone
        self.lastLogin = date
    }
}
