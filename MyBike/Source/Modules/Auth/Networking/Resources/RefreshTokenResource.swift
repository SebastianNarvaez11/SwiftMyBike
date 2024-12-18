//
//  RefreshTokenResource.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 6/11/24.
//

import Foundation

struct RefreshTokenResource: ApiResourceProtocol {
    typealias ResponseType = LoginResponse
    // La url es: "/auth/v1/token?grant_type=refresh_token"
    
    var path: String = "/auth/v1/token"
    
    var grantType: String = "refresh_token"

    var queryItems: [URLQueryItem]? {
        var items = [URLQueryItem]()
        
        items.append(URLQueryItem(name: "grant_type", value: grantType))
        
        return items.isEmpty ? nil : items
    }
}
