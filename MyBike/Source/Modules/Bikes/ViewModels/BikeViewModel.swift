//
//  BikeViewModel.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 17/12/24.
//

import Foundation




class BikeViewModel: ObservableObject {
    @Published var originalBikes: [BikeModel] = []
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var showAlert: Bool = false
    
    //Paginacion
    @Published var paginationStatus: PaginationStatus = .initialLoading
    @Published var hasNextPage: Bool = false
    var currentPage: Int = 0
    let offset: Int = 4
    
    private let repository: BikeRepository
    
    init(repository: BikeRepository = BikeRepositoryImp()) {
        self.repository = repository
    }
    
    @MainActor func getAllBikes() async -> Void {
        do {
            print("cargando la pagina \(currentPage)")
            guard !isLoading else { return  }
            defer {
                isLoading = false
                self.currentPage = self.currentPage + 1
                self.paginationStatus = .success
            }
            
            isLoading = true
            
            let bikesResponse = try await self.repository.getAllBikes(take: offset, offset: self.currentPage * offset)
            
            if bikesResponse.isEmpty {
                return self.hasNextPage = false
            } else {
                self.hasNextPage = true
            }
            
            for bike in bikesResponse {
                let signedUrlRes = try? await self.repository.getSignedUrl(data: GetSignedUrlBodyRequest(expiresIn: 3600), imageKey: bike.photo1 ?? "")
                
                self.originalBikes.append(BikeModel(fromDTO: bike, signedUrl: signedUrlRes?.signedURL ))
            }
        } catch {
            print("Ocurrio un error: \(error)")
            self.errorMessage = error.localizedDescription
            self.showAlert = true
            return
        }
    }
}
