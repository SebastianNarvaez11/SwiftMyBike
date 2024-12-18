//
//  ProfileScreen.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 6/11/24.
//

import SwiftUI

struct OnboardingProfileScreen: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var profileVM: ProfileViewModel
    @EnvironmentObject var router: MainRouter
    
    @StateObject var profileForm =  CreateProfileFormViewModel()
    @StateObject var imageSelectorVM = ImageSelectorViewModel()
    @StateObject var bikeVM = BikeViewModel()
    
    @State var originalBikes: [BikeModel] = []
    @State var showSuccessAlert: Bool = false
    
    var body: some View {
        ScreenLayout(){
            VStack(alignment: .center, spacing: 20){
                
                AuthHeaderView(title: "Completa tu perfil")
                
                SelectImageFieldView(imageSelectorVM: imageSelectorVM){
                    Circle()
                        .foregroundStyle(Color(.systemGray4))
                        .frame(width: 100)
                        .overlay{
                            Image(systemName: "photo")
                                .resizable()
                                .foregroundStyle(Color(.systemGray))
                                .scaledToFit()
                                .frame(width: 40)
                        }.overlay{
                            if let image = imageSelectorVM.images.first {
                                Image(uiImage: image.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                            }
                        }
                    
                }
                
                TextFieldView(
                    value: $profileForm.name,
                    label: "Nombre",
                    placeholder: "Tu nombre",
                    hasError: !profileForm.isNameValid && profileForm.isPressedSubmit,
                    errorMessage: "El nombre debe tener minimo 3 caracteres")
                
                
                ButtonView(
                    label: "Continuar",
                    isLoading: profileVM.isLoading || profileVM.isUploading,
                    action: {handleCreateProfile()}
                )
                
            }
            .padding(.top, 30)
        }.alert(isPresented: $profileVM.showAlert){
            Alert(
                title: Text("Algo salio mal"),
                message: Text(profileVM.errorMessage ?? "Error desconocido"),
                dismissButton: .default(Text("Cerrar")) {
                    profileVM.errorMessage = nil
                    profileVM.showAlert = false
                })
        }.onAppear(){
            Task{
                originalBikes = await bikeVM.getAllBikes()
//                TODO: ESTAMOS PINTANDO LAS MOTOS ORIGINALES PARA QUE EL USUARIO ESCOJA
//                HAY QUE REVISAR COMO SE HACE LA PAGINACION EN SUPABASE
            }
        }
    }
    
    func handleCreateProfile() {
        profileForm.isPressedSubmit = true
        
        Task {
            guard let user = authVM.user else { return }
            
            guard profileForm.isNameValid else { return }
            
            let imageKey: String? = imageSelectorVM.images.first != nil
                ? await profileVM.uploadProfileImage(image: imageSelectorVM.images.first!, userId: user.id)
                : nil
            
            let profileRequest = CreateProfileBodyRequest(name: profileForm.name, userId: user.id, image: imageKey)
            
            let isSuccess = await profileVM.createProfile(profile: profileRequest)
            
            if isSuccess {
                router.navigateTo(route: .home)
            }
        }
    }

    
}

#Preview {
    OnboardingProfileScreen()
        .environmentObject(AuthViewModel())
        .environmentObject(ProfileViewModel())
}
