//
//  RefreshTokenResource.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 6/11/24.
//

import Foundation

struct RefreshTokenResource: ApiResourceProtocol {
    typealias ResponseType = RefreshTokenResponse
    var path: String = "/api/v1/auth/refresh-token"
    var queryItems: [URLQueryItem]? = nil
}
