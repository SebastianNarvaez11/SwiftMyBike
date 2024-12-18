//
//  AuthRepository.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 7/12/24.
//

import Foundation

struct AuthRepositoryImp: AuthRepository {
    
    func login(data: LoginBodyRequest) async throws -> LoginResponse {
        let resource = LoginResource()
        let request = ApiRequest(resource: resource)
        let response = try await request.execute(method: "POST", body: data, hasApiKey: true)
        return response
    }
    
    func register(data: RegisterBodyRequest) async throws -> RegisterResponse {
        let resource = RegisterResource()
        let request = ApiRequest(resource: resource)
        let response = try await request.execute(method: "POST", body: data, hasApiKey: true)
        return response
    }
    
    func checkAuthStatus() async throws -> CheckStatusResponse {
        let resource = CheckStatusResource()
        let request = ApiRequest(resource: resource)
        let response = try await request.execute(method: "GET", hasToken: true, hasApiKey: true)
        return response
    }
}
