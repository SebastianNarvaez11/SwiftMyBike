//
//  GetSignedUrlResource.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 14/12/24.
//

import Foundation

struct GetSignedUrlResource: ApiResourceProtocol {
    typealias ResponseType = GetSignedUrlResponse
    let imageKey: String
    var path: String {
        return  "/storage/v1/object/sign/\(imageKey)"
    }
    let queryItems: [URLQueryItem]? = nil
}
