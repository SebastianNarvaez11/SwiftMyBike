//
//  BikeRepository.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 17/12/24.
//

import Foundation

protocol BikeRepository {
    func getAllBikes() async throws -> GetAllBikesResponse
}
