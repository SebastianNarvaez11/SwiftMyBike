//
//  ProfileRepository.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 7/12/24.
//

import Foundation

protocol ProfileRepository {
    func getProfileById(userId: String) async throws -> ProfileResponse
    func createProfile(profile: CreateProfileBodyRequest) async throws -> CreateProfileResponse
    func uploadProfileImage(imageData: UploadImageRequest) async throws -> UploadImageResponse
}
