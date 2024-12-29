//
//  CreateProfileResource.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 11/12/24.
//

import Foundation

struct CreateProfileResource: ApiResourceProtocol {
    typealias ResponseType = CreateProfileResponse
    let baseURL: String = ApiConfig.baseURL
    let path: String = "/rest/v1/profile"
    let queryItems: [URLQueryItem]? = nil
}
