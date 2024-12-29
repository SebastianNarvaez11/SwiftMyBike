//
//  CreateUserBikeResource.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 21/12/24.
//

import Foundation

struct CreateUserBikeResource: ApiResourceProtocol {
    typealias ResponseType = CreateUserBikeResponse
    let baseURL: String = ApiConfig.baseURL
    var path: String = "/rest/v1/user_bikes"
    var queryItems: [URLQueryItem]? = nil
}
