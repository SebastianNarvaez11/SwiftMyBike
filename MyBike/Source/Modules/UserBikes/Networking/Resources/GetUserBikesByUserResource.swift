//
//  GetUserBikesByUserResource.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 22/12/24.
//

import Foundation

struct GetUserBikesByUserResource: ApiResourceProtocol {
    typealias ResponseType = GetUserBikesByUserResponse
    let baseURL: String = ApiConfig.baseURL
    ////rest/v1/user_bikes?user_id=eq.5d43532f-416b-4b16-863e-6fc63819e4eb&select=*,bike(*,brand(*))
    
    var path: String = "/rest/v1/user_bikes"
    var userId: String
    var select: String = "*,bike(*,brand(*))"
    
    var queryItems: [URLQueryItem]? {
        var items = [URLQueryItem]()
        
        items.append(URLQueryItem(name: "user_id", value: "eq.\(userId)"))
        items.append(URLQueryItem(name: "select", value: select))
        
        return items.isEmpty ? nil : items
    }
}
