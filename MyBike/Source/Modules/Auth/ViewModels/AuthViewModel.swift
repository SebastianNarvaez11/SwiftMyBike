//
//  AuthViewModel.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 6/11/24.
//

import Foundation

class AuthViewModel: ObservableObject {
    @Published var status: AuthStatus = .unauthenticated
    @Published var user: UserModel? = nil
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var showAlert: Bool = false
    
    let tokenManager = TokenManager()
    
    private let repository: AuthRepositoryProtocol
    
    init(repository: AuthRepositoryProtocol = AuthRepository()) {
        self.repository = repository
    }
    
    @MainActor func login(data: LoginBodyRequest) async -> Void {
        do{
            guard !isLoading else { return }
            defer { isLoading = false }
            isLoading = true
            
            let res = try await self.repository.login(data: data)
            
            self.user = UserModel(fromDTO: res.user)
            tokenManager.saveTokens(accessToken: res.accessToken, refreshToken: res.refreshToken)
            self.status = .authenticated
            
            print(self.user ?? "")
        } catch{
            print("Ocurrio un error: \(error)")
            self.errorMessage = error.localizedDescription
            self.showAlert = true
            self.status = .unauthenticated
        }
    }
}
