//
//  RegisterScreen.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 8/12/24.
//

import SwiftUI

struct RegisterScreen: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var router: AuthRouter
    
    @StateObject var loginForm = LoginFormViewModel()
    
    var body: some View {
        ScreenLayout(goBack: { router.navigateBack() }){
            VStack(alignment: .center, spacing: 20){
                
                AuthHeaderView(title: "Registrarse")
                
                ButtonView(label: "Google", action: {})
                
//                TextFieldView(
//                    value: $loginForm.email,
//                    label: "Correo",
//                    placeholder: "Tu correo",
//                    hasError: !loginForm.isValidEmail && loginForm.isSubmitPressed,
//                    errorMessage: "Ingresa un correo valido")
//                
//                TextFieldView(
//                    value: $loginForm.password,
//                    label: "Contraseña",
//                    placeholder: "Tu contraseña",
//                    hasError: !loginForm.isValidPassword && loginForm.isSubmitPressed,
//                    errorMessage: "Este campo es requerido",
//                    isSecure: true
//                )
//                
//                ButtonView(
//                    label: "Iniciar sesion",
//                    isLoading: authViewModel.isLoading,
//                    action: {
//                        loginForm.isSubmitPressed = true
//                        Task{
//                            if(loginForm.isValidForm){
//                                await authViewModel.login(data: LoginBodyRequest(email: loginForm.email, password: loginForm.password))
//                            }
//                        }
//                    })
            }
            .padding(.top, 30)
        }.alert(isPresented: $authViewModel.showAlert){
            Alert(
                title: Text("Algo salio mal"),
                message: Text(authViewModel.errorMessage ?? "Error desconocido"),
                dismissButton: .default(Text("Cerrar")) {
                    authViewModel.errorMessage = nil
                    authViewModel.showAlert = false
                })
        }
    }
}

#Preview {
    RegisterScreen()
        .environmentObject(AuthRouter())
        .environmentObject(AuthViewModel())
}
