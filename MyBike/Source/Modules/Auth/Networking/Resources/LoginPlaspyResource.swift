//
//  LoginPlaspyResource.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 25/12/24.
//

import Foundation

struct LoginPlaspyResource: ApiResourceProtocol {
    typealias ResponseType = LoginPlaspyResponse
    var baseURL: String = ApiConfig.baseUrlPlaspy
    var path: String = "/api/Auth/Token"
    var queryItems: [URLQueryItem]? = nil
}
