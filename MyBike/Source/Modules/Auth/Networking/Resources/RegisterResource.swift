//
//  RegisterResource.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 9/12/24.
//

import Foundation

struct RegisterResource: ApiResourceProtocol {
    typealias ResponseType = RegisterResponse
    let baseURL: String = ApiConfig.baseURL
    let path: String = "/auth/v1/signup"
    let queryItems: [URLQueryItem]? = nil
}
