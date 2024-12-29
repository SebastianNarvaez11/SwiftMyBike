//
//  AuthViewModel.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 6/11/24.
//

import Foundation
import Supabase
import AuthenticationServices
import LocalAuthentication

class AuthViewModel: ObservableObject {
    @Published var status: AuthStatus = .unauthenticated
    @Published var user: UserModel? = nil
    @Published var isLoading: Bool = false
    @Published var alertMessage: String? = nil
    @Published var showAlert: Bool = false
    @Published var showFaceIdQuestionAlert: Bool = false
    
    let defaults = UserDefaults.standard
    
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
            
            let isFaceIdEnabled: Bool =  self.defaults.bool(forKey: "isFaceIDEnabled")
            
            if (deviceHasFaceId() && !isFaceIdEnabled) {
                // si tiene face id, preguntas si desea usarlo para futuros inicios de sesion
                showFaceIdQuestionAlert = true
            } else {
                // si no tiene, como el login fue exitoso, simplemente dejamos seguir
                self.status = .checkingProfile
            }
            
            
        } catch{
            print("Ocurrio un error: \(error)")
            self.alertMessage = error.localizedDescription
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
            self.alertMessage = error.localizedDescription
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
            print("error al revisar el estado de la autenticacion: \(error.localizedDescription)")
            self.alertMessage = "Tu sesion ha expirado, vuelve a iniciar sesion con tus credenciales"
            self.showAlert = true
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
            
            let isFaceIdEnabled: Bool =  self.defaults.bool(forKey: "isFaceIDEnabled")
            
            if (deviceHasFaceId() && !isFaceIdEnabled) {
                // si tiene face id, preguntas si desea usarlo para futuros inicios de sesion
                showFaceIdQuestionAlert = true
            } else {
                // si no tiene, como el login fue exitoso, simplemente dejamos seguir
                self.status = .checkingProfile
            }
            
        } catch {
            print(error)
        }
    }
    
    @MainActor func loginPlaspy() async -> Bool {
        do {
            guard !isLoading else { return false}
            defer { isLoading = false }
            isLoading = true
            
            let res = try await self.repository.loginPlaspy(data: LoginPlaspyBodyRequest(userName: ApiConfig.userPlaspy, apiKey: ApiConfig.apiKeyPlaspy))
            
            tokenManager.savePlaspyToken(token: res.token)
            
            return true
        } catch {
            print(error)
            print("error al obtener el token de plaspy: \(error.localizedDescription)")
            return false
        }
    }
    
    
    func logout() {
        self.status = .unauthenticated
        self.user = nil
        tokenManager.removeTokens()
        self.defaults.set(false, forKey: "isFaceIDEnabled")
    }
    
    func deviceHasFaceId() -> Bool {
        var error: NSError?
        let context = LAContext()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            return true
        } else {
            return false
        }
    }
    
    @MainActor
    func authenticatedWithFaceId() async -> Bool {
        let context = LAContext()
        var error: NSError?
        
        // Verifica si el dispositivo soporta biometría y si la política de autenticación está disponible.
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return false // No se puede usar Face ID si no está disponible.
        }
        
        do {
            // Intenta autenticar al usuario con Face ID de manera asíncrona.
            _ = try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Autenticarse usando Face ID")
            return true
        } catch {
            return false
        }
    }
}
