//
//  UserModel.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 6/11/24.
//

import Foundation

struct UserModel: Identifiable, Hashable  {
    let id: String
    let name: String
    let email: String
    let phone: String
    let lastLogin: Date
}

extension UserModel {
    init(fromDTO userDto: UserLoginDTO) {
        let dateFormatter = ISO8601DateFormatter()
        print("lastSignIn: ", userDto.lastSignIn)
        let date = dateFormatter.date(from: userDto.lastSignIn) ?? Date()
        
        self.id = userDto.id
        self.name = ""
        self.email = userDto.email
        self.phone = userDto.phone
        self.lastLogin = date
    }
}
