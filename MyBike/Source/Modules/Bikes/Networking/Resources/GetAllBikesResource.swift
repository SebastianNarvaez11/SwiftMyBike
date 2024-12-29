//
//  GetAllBikesResource.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 17/12/24.
//

import Foundation

struct GetAllBikesResource: ApiResourceProtocol {
    typealias ResponseType = GetAllBikesResponse
    let baseURL: String = ApiConfig.baseURL
    
    //    /rest/v1/bike?select=*,brand(*)&limit=2&offset=6
    let path: String = "/rest/v1/bike"
    
    let select: String = "*,brand(*)" //para popular las brand
    var take: Int?
    var page: Int?
    
    var queryItems: [URLQueryItem]? {
        var items = [URLQueryItem]()
        
        items.append(URLQueryItem(name: "select", value: select))
        
        if let take = take {
            items.append(URLQueryItem(name: "limit", value: "\(take)"))
        }
        
        if let page = page {
            items.append(URLQueryItem(name: "offset", value: "\(page)"))
        }
        
        return items.isEmpty ? nil : items
    }
}
