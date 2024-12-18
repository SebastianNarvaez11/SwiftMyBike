//
//  ProfileRepositoryImp.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 7/12/24.
//

import Foundation

struct ProfileRepositoryImp: ProfileRepository {
    
    func getProfileById(userId: String) async throws -> ProfileResponse {
        let resource = GetProfileByIdResource(userId: userId)
        let request = ApiRequest(resource: resource)
        let response = try await request.execute(method: "GET", hasToken: true, hasApiKey: true)
        return response
    }
    
    func createProfile(profile: CreateProfileBodyRequest) async throws -> CreateProfileResponse {
        let resource = CreateProfileResource()
        let request = ApiRequest(resource: resource)
        let response = try await request.execute(method: "POST",body: profile, hasToken: true, hasApiKey: true)
        return response
    }
    
    func uploadProfileImage(imageData: UploadImageRequest) async throws -> UploadImageResponse {
        let resource = UploadImageResource(fileName: "\(imageData.userId).\(imageData.image.ext)", folderName: "profiles")
        let request = ApiRequest(resource: resource)
        let response = try await request.execute(method: "POST", hasToken: true, hasApiKey: true, imageData: imageData)
        return response
    }
}
