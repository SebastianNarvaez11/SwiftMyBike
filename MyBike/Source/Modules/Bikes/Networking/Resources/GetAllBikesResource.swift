//
//  GetAllBikesResource.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 17/12/24.
//

import Foundation

struct GetAllBikesResource: ApiResourceProtocol {
    typealias ResponseType = GetAllBikesResponse
    
    //    /rest/v1/bike?select=*,brand(*)
    let path: String = "/rest/v1/bike"
    
    let select: String = "*,brand(*)" //para popular las brand
    
    var queryItems: [URLQueryItem]? {
        var items = [URLQueryItem]()
        
        items.append(URLQueryItem(name: "select", value: select))
        
        return items.isEmpty ? nil : items
    }
}
