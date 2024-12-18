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
