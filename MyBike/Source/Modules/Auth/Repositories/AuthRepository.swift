//
//  AuthRepository.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 7/12/24.
//

import Foundation

struct AuthRepository: AuthRepositoryProtocol {
    
    func login(data: LoginBodyRequest) async throws -> LoginResponse {
        let resource = LoginResource()
        let request = ApiRequest(resource: resource)
        let response = try await request.execute(method: "POST", body: data, hasApiKey: true)
        return response
    }
}
