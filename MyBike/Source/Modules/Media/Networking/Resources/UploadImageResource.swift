//
//  UploadImageResource.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 14/12/24.
//

import Foundation

struct UploadImageResource: ApiResourceProtocol {
    typealias ResponseType = UploadImageResponse
    let baseURL: String = ApiConfig.baseURL
    
    let fileName: String
    let folderName: String
    
    var path: String {
        return "/storage/v1/object/MyBikeBucket/\(folderName)/\(self.fileName)"
    }
    let queryItems: [URLQueryItem]? = nil
}
