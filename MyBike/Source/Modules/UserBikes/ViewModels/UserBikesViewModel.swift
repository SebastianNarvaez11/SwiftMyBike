//
//  UserBikesViewModel.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 21/12/24.
//

import Foundation

class UserBikesViewModel: ObservableObject {
    @Published var userBike: UserBikeModel?
    @Published var lastLocation: LastLocationModel?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var showAlert: Bool = false
    
    let defaults = UserDefaults.standard
    
    let tokenManager = TokenManager()
    
    private let repository: UserBikesRepository
    
    init( repository: UserBikesRepository = UserBikesRepositoryImp()) {
        self.repository = repository
    }
    
    func createUserBike(data: CreateUserBikeBodyRequest) async -> Bool {
        do {
            guard !isLoading else { return false }
            defer { isLoading = false }
            isLoading = true
            
            _ = try await self.repository.createUserBike(data: data)
            
            return true
        } catch {
            print("Ocurrio un error: \(error)")
            self.errorMessage = error.localizedDescription
            self.showAlert = true
            return false
        }
    }
    
    @MainActor
    func getUserBikesByUserId(userId: String) async -> Bool {
        do {
            guard !isLoading else { return false }
            defer { isLoading = false }
            isLoading = true
            
            let res = try await self.repository.getUserBikesByUserId(userId: userId)
            
            if res.isEmpty { return false }
            
            if let bikeDTO = res.first {
                let signedUrlRes = try? await self.repository.getSignedUrl(data: GetSignedUrlBodyRequest(expiresIn: 3600), imageKey: bikeDTO.bike.photo1 ?? "")
                
                self.userBike = UserBikeModel(fromDTO: bikeDTO, signedUrl: signedUrlRes?.signedURL)
                
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
    
    @MainActor
    func getLastLocation() async -> LastLocationModel? {
        do {
            let token = tokenManager.accessTokenPlaspy
            
            guard !isLoading else { return nil }
            guard userBike?.gpsId != nil else { return nil }
            guard token != nil else { return nil }
            defer { isLoading = false }
            isLoading = true
            
            let res = try await self.repository.getLastLocation(deviceId: userBike!.gpsId!, token: token!)
            
            let location: LastLocationModel = LastLocationModel(fromDto: res.lastLocation)
            
            self.lastLocation = location
            defaults.set(location.latitude, forKey: "lastBikeLatitude")
            defaults.set(location.longitude, forKey: "lastBikeLongitude")
            
            return location
        } catch {
            print("Ocurrio un error: \(error)")
            self.errorMessage = error.localizedDescription
            self.showAlert = true
            return nil
        }
    }
}
