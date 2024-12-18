//
//  MediaViewModel.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 6/11/24.
//

import Foundation

class MediaViewModel: ObservableObject {
    @Published var isSigning: Bool = false
    
    @Published var errorMessage: String? = nil
    @Published var showAlert: Bool = false
    
    
    private let repository: MediaRepository
    
    init(repository: MediaRepository = MediaRepositoryImp()) {
        self.repository = repository
    }
    
    @MainActor func getSignedUrl(imageKey: String) async -> String? {
        do{
            guard !isSigning else { return nil}
            defer { isSigning = false }
            isSigning = true
            
            let res = try await self.repository.getSignedUrl(data: GetSignedUrlBodyRequest(expiresIn: 3600), imageKey: imageKey)
            
            let url = "\(ApiConfig.baseURL)/storage/v1/\(res.signedURL)"
            return url
        } catch {
            print("Ocurrio un error: \(error)")
            self.errorMessage = error.localizedDescription
            self.showAlert = true
            return nil
        }
    }
}
