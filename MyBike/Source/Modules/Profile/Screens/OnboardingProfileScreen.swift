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
    @EnvironmentObject var userBikesVM: UserBikesViewModel
    
    @StateObject var profileForm =  CreateProfileFormViewModel()
    @StateObject var imageSelectorVM = ImageSelectorViewModel()
    
    @State var selectedBike: BikeModel?
    
    @State var showSuccessAlert: Bool = false
    
    var body: some View {
        ScreenLayout(withScroll:true){
            VStack(alignment: .center, spacing: 10){
                
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
                
                Text("Selecciona tu moto").typography(.bold, 15)
                
                BikesCarrouselView(selectedBike: $selectedBike)
                
                ButtonView(
                    label: "Continuar",
                    isLoading: profileVM.isLoading || profileVM.isUploading,
                    disabled: selectedBike == nil,
                    action: { handleCreateProfile() }
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
        }
    }
    
    func handleCreateProfile() {
        profileForm.isPressedSubmit = true
        
        Task {
            guard let user = authVM.user else { return }
            guard profileForm.isNameValid else { return }
            guard let bike = selectedBike else { return }
            
            let imageKey: String? = imageSelectorVM.images.first != nil
            ? await profileVM.uploadProfileImage(image: imageSelectorVM.images.first!, userId: user.id)
            : nil
            
            let profileBody = CreateProfileBodyRequest(name: profileForm.name, userId: user.id, image: imageKey)
            let userBikeBody = CreateUserBikeBodyRequest(userId: user.id, bikeId: bike.id)
            
            let isSuccessProfile = await profileVM.createProfile(profile: profileBody)
            
            if(isSuccessProfile){
                let isSuccessBike = await userBikesVM.createUserBike(data: userBikeBody)
                
                if isSuccessBike {
                    authVM.status = .checkingProfile
                }
            }
            
        }
    }
    
    
}

#Preview {
    OnboardingProfileScreen()
        .environmentObject(AuthViewModel())
        .environmentObject(ProfileViewModel())
        .environmentObject(UserBikesViewModel())
}
