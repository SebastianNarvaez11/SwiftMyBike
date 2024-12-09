//
//  TokenManagerProtocol.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 7/12/24.
//

import Foundation

protocol TokenManagerProtocol {
    var accessToken: String? { get }
    var refreshToken: String? { get }
    
    func saveTokens(accessToken: String, refreshToken: String)
    func removeTokens()
    func refreshAccessToken() async throws
}
