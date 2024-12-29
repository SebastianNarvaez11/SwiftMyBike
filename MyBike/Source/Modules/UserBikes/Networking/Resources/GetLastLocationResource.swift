//
//  GetLastLocationResource.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 25/12/24.
//

import Foundation

struct GetLastLocationResource: ApiResourceProtocol {
    typealias ResponseType = GetLastLocationResponse
    var baseURL: String = ApiConfig.baseUrlPlaspy
    
    var deviceId: String
    
    var path: String {
        return "/api/devices/\(deviceId)/lastLocation"
    }
    
    var queryItems: [URLQueryItem]? = nil
}
