//
//  BikeRepository.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 17/12/24.
//

import Foundation

protocol BikeRepository: MediaRepository {
    func getAllBikes(take: Int?, offset: Int?) async throws -> GetAllBikesResponse
}
