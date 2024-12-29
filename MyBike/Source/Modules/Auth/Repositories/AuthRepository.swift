//
//  AuthRepositoryProtocol.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 7/12/24.
//

import Foundation

protocol AuthRepository {
    func login(data: LoginBodyRequest) async throws -> LoginResponse
    func register(data: RegisterBodyRequest) async throws -> RegisterResponse
    func checkAuthStatus() async throws -> CheckStatusResponse
    func loginPlaspy(data: LoginPlaspyBodyRequest) async throws -> LoginPlaspyResponse
}
