//
//  BikeRepositoryImp.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 17/12/24.
//

import Foundation

struct BikeRepositoryImp: BikeRepository {
    func getAllBikes() async throws -> GetAllBikesResponse {
        let resource = GetAllBikesResource()
        let request = ApiRequest(resource: resource)
        let response = try await request.execute(method: "GET", hasToken: true, hasApiKey: true)
        return response
    }
}
