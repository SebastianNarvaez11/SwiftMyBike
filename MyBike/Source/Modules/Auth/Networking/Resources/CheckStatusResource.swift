//
//  CheckStatusResource.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 7/11/24.
//

import Foundation

struct CheckStatusResource: ApiResourceProtocol {
    typealias ResponseType = CheckStatusResponse
    let baseURL: String = ApiConfig.baseURL
    var path: String = "/auth/v1/user"
    var queryItems: [URLQueryItem]? = nil
}
