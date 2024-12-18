//
//  RegisterScreen.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 8/12/24.
//

import SwiftUI
import Supabase
import AuthenticationServices

struct RegisterScreen: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var router: AuthRouter
    
    @StateObject var registerForm = RegisterFormViewModel()
    @State var showSuccessAlert: Bool = false
    
    var body: some View {
        ScreenLayout(withScroll: true, goBack: { router.navigateBack() }){
            VStack(alignment: .center, spacing: 20){
                
                AuthHeaderView(title: "Registrarse")
                
                TextFieldView(
                    value: $registerForm.email,
                    label: "Tu correo",
                    placeholder: "Email",
                    hasError: !registerForm.isEmailValid && registerForm.isPressedSubmit,
                    errorMessage: "Ingresa un correo valido")
                
                TextFieldView(
                    value: $registerForm.password,
                    label: "Contraseña",
                    placeholder: "******",
                    hasError: !registerForm.isPasswordValid && registerForm.isPressedSubmit,
                    errorMessage: "La contraseña debe tener minimo 6 caracteres",
                    isSecure: true)
                
                TextFieldView(
                    value: $registerForm.confirmPassword,
                    label: "Confirma la contraseña",
                    placeholder: "******",
                    hasError: !registerForm.isConfirmPasswordValid && registerForm.isPressedSubmit,
                    errorMessage: "Las contraseñas no coinciden",
                    isSecure: true)
                
                ButtonView(
                    label: "Registrarse",
                    isLoading: authViewModel.isLoading,
                    action: {
                        registerForm.isPressedSubmit = true
                        Task{
                            if(registerForm.isValidForm){
                                let isSuccess = await authViewModel.register(data: RegisterBodyRequest(
                                    email: registerForm.email,
                                    password: registerForm.password)
                                )
                                
                                if(isSuccess){
                                    showSuccessAlert = true
                                }
                            }
                        }
                    })
                
                VStack{}
                    .frame(maxWidth: .infinity)
                    .frame(height: 1)
                    .background(Color(.systemGray3))
                
                
                ButtonView(
                    label: "Registrarse con Google",
                    action: {
                        Task {
                            await authViewModel.singInWithGoogle()
                        }
                    })
                
                
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
        }.alert("Te enviamos un correo para verificar tu cuenta. Verifícalo e inicia sesión.", isPresented: $showSuccessAlert){
            Button("OK", action: { router.navigateBack() })
        }
    }
}

#Preview {
    RegisterScreen()
        .environmentObject(AuthRouter())
        .environmentObject(AuthViewModel())
}
