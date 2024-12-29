//
//  MediaRepository.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 7/12/24.
//

import Foundation

protocol MediaRepository {
    func getSignedUrl(data: GetSignedUrlBodyRequest, imageKey: String) async throws -> GetSignedUrlResponse
}

extension MediaRepository {
    func getSignedUrl(data: GetSignedUrlBodyRequest, imageKey: String) async throws -> GetSignedUrlResponse {
        let resource = GetSignedUrlResource(imageKey: imageKey)
        let request = ApiRequest(resource: resource)
        let response = try await request.execute(method: "POST", body: data, hasToken: true, hasApiKey: true)
        return response
    }
}
