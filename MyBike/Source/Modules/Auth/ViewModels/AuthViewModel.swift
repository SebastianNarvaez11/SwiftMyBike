//
//  AuthViewModel.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 6/11/24.
//

import Foundation
import Supabase
import AuthenticationServices

class AuthViewModel: ObservableObject {
    @Published var status: AuthStatus = .checking
    @Published var user: UserModel? = nil
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var showAlert: Bool = false
    
    let tokenManager = TokenManager()
    
    private let repository: AuthRepository
    
    init(repository: AuthRepository = AuthRepositoryImp()) {
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
            self.status = .checkingProfile
            
        } catch{
            print("Ocurrio un error: \(error)")
            self.errorMessage = error.localizedDescription
            self.showAlert = true
            self.status = .unauthenticated
        }
    }
    
    @MainActor func register(data: RegisterBodyRequest) async -> Bool {
        do{
            guard !isLoading else { return false }
            defer { isLoading = false }
            isLoading = true
            
            _ = try await self.repository.register(data: data)
            
            return true
        } catch {
            print("Ocurrio un error: \(error)")
            self.errorMessage = error.localizedDescription
            self.showAlert = true
            return false
        }
    }
    
    @MainActor func checkAuthStatus() async -> Void {
        do{
            guard !isLoading else { return }
            defer { isLoading = false }
            isLoading = true
            
            let userDto = try await self.repository.checkAuthStatus()
            
            self.user = UserModel(fromDTO: userDto)
            self.status = .checkingProfile
        } catch {
            print(error)
            print("error al revisar el estado de la autenticacion: \(error.localizedDescription)")
            self.logout()
        }
    }
    
    @MainActor func singInWithGoogle() async -> Void {
        do{
            let session = try await supabaseClient.auth.signInWithOAuth(
                provider: .google,
                redirectTo: URL(string: "supabase://auth-callback") // Configura este URI en tu Info.plist
            ) { (asWebAuthSession: ASWebAuthenticationSession) in
                asWebAuthSession.prefersEphemeralWebBrowserSession = true // Opcional
            }
            
            self.user = UserModel(id: "\(session.user.id)", email: session.user.email!, phone: session.user.phone ?? "", lastLogin: session.user.lastSignInAt ?? Date())
            tokenManager.saveTokens(accessToken: session.accessToken, refreshToken: session.refreshToken)
            self.status = .checkingProfile
            
        } catch {
            print(error)
        }
    }
    func logout() {
        self.status = .unauthenticated
        self.user = nil
        tokenManager.removeTokens()
    }
}
