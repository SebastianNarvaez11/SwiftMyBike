//
//  UserBikesRepository.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 21/12/24.
//

import Foundation

protocol UserBikesRepository: MediaRepository {
    func createUserBike(data: CreateUserBikeBodyRequest) async throws -> CreateUserBikeResponse
    func getUserBikesByUserId(userId: String) async throws -> GetUserBikesByUserResponse
    func getLastLocation(deviceId: String, token: String) async throws -> GetLastLocationResponse
}
