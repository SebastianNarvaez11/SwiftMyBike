//
//  UploadImageResource.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 14/12/24.
//

import Foundation

struct UploadImageResource: ApiResourceProtocol {
    typealias ResponseType = UploadImageResponse
    
    let fileName: String
    let folderName: String
    
    var path: String {
        return "/storage/v1/object/MyBikeBucket/\(folderName)/\(self.fileName)"
    }
    let queryItems: [URLQueryItem]? = nil
}
