//
//  AuthRepositoryProtocol.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 7/12/24.
//

import Foundation

protocol AuthRepositoryProtocol {
    func login(data: LoginBodyRequest) async throws -> LoginResponse
}
