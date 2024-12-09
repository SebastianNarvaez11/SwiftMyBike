//
//  LoginResource.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 6/11/24.
//

import Foundation

struct LoginResource: ApiResourceProtocol {
    typealias ResponseType = LoginResponse
    
    // La url es: "/auth/v1/token?grant_type=password"
    
    var path: String = "/auth/v1/token"
    
    var grantType: String = "password"

    var queryItems: [URLQueryItem]? {
        var items = [URLQueryItem]()
        
        items.append(URLQueryItem(name: "grant_type", value: grantType))
        
        return items.isEmpty ? nil : items
    }
}
