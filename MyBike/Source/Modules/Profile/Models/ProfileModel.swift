//
//  ProfileModel.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 10/12/24.
//

import Foundation

struct ProfileModel: Identifiable, Hashable  {
    let id: String
    let name: String
    let userId: String
    let imageKey: String?
}

extension ProfileModel {
    init(fromDTO profileDto: ProfileDTO) {
        self.id = profileDto.id
        self.name = profileDto.name
        self.userId = profileDto.userId
        self.imageKey = profileDto.image
    }
}
