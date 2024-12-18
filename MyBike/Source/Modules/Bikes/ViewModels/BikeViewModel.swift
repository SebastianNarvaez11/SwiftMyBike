//
//  BikeViewModel.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 17/12/24.
//

import Foundation

class BikeViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var showAlert: Bool = false
    
    private let repository: BikeRepository
    
    init(repository: BikeRepository = BikeRepositoryImp()) {
        self.repository = repository
    }
    
    @MainActor func getAllBikes() async -> [BikeModel] {
        do {
            guard !isLoading else { return [] }
            defer { isLoading = false }
            isLoading = true
            
            let bikes = try await self.repository.getAllBikes()
            
            return bikes.map { bike in
                BikeModel(fromDTO: bike)
            }
        } catch {
            print("Ocurrio un error: \(error)")
            self.errorMessage = error.localizedDescription
            self.showAlert = true
            return []
        }
    }
}
