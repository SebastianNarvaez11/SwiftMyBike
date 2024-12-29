//
//  ProfileViewModel.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 6/11/24.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var profile: ProfileModel? = nil
    @Published var isLoading: Bool = false
    @Published var isUploading: Bool = false
    @Published var isSigning: Bool = false
    
    @Published var errorMessage: String? = nil
    @Published var showAlert: Bool = false
    
    
    private let repository: ProfileRepository
    
    init(repository: ProfileRepository = ProfileRepositoryImp()) {
        self.repository = repository
    }
    
    @MainActor func hasProfile(userId: String) async -> Bool {
        do{
            guard !isLoading else { return false }
            defer { isLoading = false }
            isLoading = true
            
            let res = try await self.repository.getProfileById(userId: userId)
            
            if let profileDto = res.first {
                self.profile =  ProfileModel(fromDTO: profileDto)
                return true
                
            } else {
                return false
            }
        } catch {
            print("Ocurrio un error: \(error)")
            self.errorMessage = error.localizedDescription
            self.showAlert = true
            return false
        }
    }
    
    @MainActor func createProfile(profile:CreateProfileBodyRequest) async -> Bool {
        do{
            guard !isLoading else { return false}
            defer { isLoading = false }
            isLoading = true
            
            let res = try await self.repository.createProfile(profile: profile)
            
            if let profileDto = res.first {
                self.profile =  ProfileModel(fromDTO: profileDto)
                return true
                
            } else {
                return false
            }
            
        } catch {
            print("Ocurrio un error: \(error)")
            self.errorMessage = error.localizedDescription
            self.showAlert = true
            return false
        }
    }
    
    @MainActor func uploadProfileImage(image: SelectedImage, userId: String) async -> String? {
        do{
            guard !isUploading else { return nil}
            defer { isUploading = false }
            isUploading = true
            
            let res = try await self.repository.uploadProfileImage(imageData: UploadImageRequest(image: image, userId: userId))
            
            return res.key
        } catch {
            print("Ocurrio un error: \(error)")
            self.errorMessage = error.localizedDescription
            self.showAlert = true
            return nil
        }
    }
    
    @MainActor func getSignedProfileUrl() async -> String? {
        do{
            guard !isSigning else { return nil}
            defer { isSigning = false }
            isSigning = true
            
            guard profile != nil else { return nil }
            
            if let imageKey = profile?.imageKey {
                let res = try await self.repository.getSignedUrl(data: GetSignedUrlBodyRequest(expiresIn: 3600), imageKey: imageKey)
                return "\(ApiConfig.baseURL)/storage/v1/\(res.signedURL)"
            }else {
                return nil
            }
            
        } catch {
            print("Ocurrio un error: \(error)")
            self.errorMessage = error.localizedDescription
            self.showAlert = true
            return nil
        }
    }
}
