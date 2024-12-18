//
//  ApiRequest.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 6/11/24.
//

import Foundation

class ApiRequest<Resource: ApiResourceProtocol> {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}


extension ApiRequest: NetworkRequestProtocol {
    typealias ResponseType = Resource.ResponseType
    
    func decode(data: Data) throws -> ResponseType {
        return try JSONDecoder().decode(ResponseType.self, from: data)
    }
    
    func execute(method: String, body: Encodable? = nil, hasToken: Bool = false, hasApiKey: Bool = false, imageData: UploadImageRequest? = nil) async throws -> ResponseType {
        return try await self.sendRequest(url: self.resource.url, method: method, body: body, hasToken: hasToken, hasApiKey: hasApiKey, imageData: imageData)
    }
}
