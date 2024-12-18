//
//  GetProfileByIdResource.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 10/12/24.
//

import Foundation

struct GetProfileByIdResource : ApiResourceProtocol {
    typealias ResponseType = ProfileResponse
    
    //"/rest/v1/profile?user_id=eq.6222e379-9804-4b59-9f51-0da86a6e8da8&select=*"
    
    let path: String = "/rest/v1/profile"
    
    var userId: String
    var select: String = "*"
    
    var queryItems: [URLQueryItem]? {
        var items = [URLQueryItem]()
        
        items.append(URLQueryItem(name: "user_id", value: "eq.\(userId)"))
        items.append(URLQueryItem(name: "select", value: select))
        
        return items.isEmpty ? nil : items
    }
}
