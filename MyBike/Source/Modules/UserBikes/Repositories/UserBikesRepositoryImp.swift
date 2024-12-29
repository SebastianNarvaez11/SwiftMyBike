//
//  UserBikesRepositoryImp.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 21/12/24.
//

import Foundation

struct UserBikesRepositoryImp: UserBikesRepository {
    func createUserBike(data: CreateUserBikeBodyRequest) async throws -> CreateUserBikeResponse {
        let resource = CreateUserBikeResource()
        let request = ApiRequest(resource: resource)
        let response = try await request.execute(method: "POST", body: data, hasToken: true, hasApiKey: true)
        return response
    }
    
    func getUserBikesByUserId(userId: String) async throws -> GetUserBikesByUserResponse {
        let resource = GetUserBikesByUserResource(userId: userId)
        let request = ApiRequest(resource: resource)
        let response = try await request.execute(method: "GET", hasToken: true, hasApiKey: true)
        return response
    }
    
    func getLastLocation(deviceId: String, token: String) async throws -> GetLastLocationResponse {
        let resource = GetLastLocationResource(deviceId: deviceId)
        let request = ApiRequest(resource: resource)
        let response = try await request.execute(method: "GET", hasToken: true, token: token)
        return response
    }
}
