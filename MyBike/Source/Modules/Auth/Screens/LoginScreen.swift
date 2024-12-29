//
//  LoginScreen.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 4/11/24.
//

import SwiftUI

struct LoginScreen: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var router: AuthRouter
    
    @StateObject var loginForm = LoginFormViewModel()
    
    @AppStorage("isFaceIDEnabled") var isFaceIDEnabled: Bool = false
    
    var body: some View {
        ScreenLayout(withScroll: true){
            VStack(alignment: .center, spacing: 20){
                
                AuthHeaderView(title: "Iniciar sesion")
                
                TextFieldView(
                    value: $loginForm.email,
                    label: "Correo",
                    placeholder: "Tu correo",
                    hasError: !loginForm.isValidEmail && loginForm.isSubmitPressed,
                    errorMessage: "Ingresa un correo valido")
                
                TextFieldView(
                    value: $loginForm.password,
                    label: "Contraseña",
                    placeholder: "Tu contraseña",
                    hasError: !loginForm.isValidPassword && loginForm.isSubmitPressed,
                    errorMessage: "Este campo es requerido",
                    isSecure: true
                )
                
                HStack(spacing: 30){
                    ButtonView(
                        label: "Iniciar sesion",
                        isLoading: authViewModel.isLoading,
                        action: {
                            loginForm.isSubmitPressed = true
                            Task{
                                if(loginForm.isValidForm){
                                    await authViewModel.login(data: LoginBodyRequest(email: loginForm.email, password: loginForm.password))
                                }
                            }
                        })
                    
                    if isFaceIDEnabled {
                        Button(action: {
                            Task{
                                if await authViewModel.authenticatedWithFaceId() {
                                    await authViewModel.checkAuthStatus()
                                }
                            }
                        }, label: {
                            Image(systemName: "faceid")
                                .resizable()
                                .foregroundStyle(.defaultText)
                                .scaledToFill()
                                .padding(10)
                                .frame(width: 60, height: 60)
                        })
                    }
                    
                }
                
                ButtonView(
                    label: "Iniciar sesion con Google",
                    action: {
                        Task {
                            await authViewModel.singInWithGoogle()
                        }
                    }).background()
                
                ButtonView(label: "Registrarse", isOutline: true, action: {router.navigateTo(route: .register)})
            }
            .padding(.top, 30)
        }.alert(isPresented: $authViewModel.showAlert){
            Alert(
                title: Text("Algo salio mal"),
                message: Text(authViewModel.alertMessage ?? "Error desconocido"),
                dismissButton: .default(Text("Cerrar")) {
                    authViewModel.alertMessage = nil
                    authViewModel.showAlert = false
                })
        }.alert(isPresented: $authViewModel.showFaceIdQuestionAlert){
            Alert(
                title: Text("Habilitar Face Id"),
                message: Text("¿Deseas habilidar Face Id para futuros inicios de sesion?"),
                primaryButton: .default(Text("Si")){
                    authViewModel.showFaceIdQuestionAlert = false
                    Task {
                        // si acepta usar face id, empezamos el proceso y si sale bien
                        // establecemos la bandera de face id en true y dejamos pasar
                        if await authViewModel.authenticatedWithFaceId() {
                            isFaceIDEnabled = true
                            authViewModel.status = .checkingProfile
                        }
                    }
                },
                secondaryButton: .cancel(Text("No")) {
                    isFaceIDEnabled = false
                    authViewModel.showFaceIdQuestionAlert = false
                    authViewModel.status = .checkingProfile
                })
        }.onAppear(){
            if isFaceIDEnabled {
                Task {
                    if await authViewModel.authenticatedWithFaceId() {
                        await authViewModel.checkAuthStatus()
                    }
                }
            }
        }
    }
}

#Preview {
    LoginScreen()
        .environmentObject(AuthRouter())
        .environmentObject(AuthViewModel())
}
