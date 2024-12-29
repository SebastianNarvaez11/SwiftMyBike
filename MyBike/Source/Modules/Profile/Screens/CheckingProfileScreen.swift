//
//  CheckingProfileScreen.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 5/11/24.
//

import SwiftUI

struct CheckingProfileScreen: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @EnvironmentObject var userBikeVM: UserBikesViewModel
    
    var body: some View {
        ScreenLayout{
            Spacer()
            
            VStack(alignment: .center, spacing: 30){
                
                Image("icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
                SpinnerView()
            }
        }
        .onAppear(){
            Task{
                guard let user = authViewModel.user else { return }
                
                async let hasProfile = profileViewModel.hasProfile(userId: user.id)
                async let hasBike = userBikeVM.getUserBikesByUserId(userId: user.id)
                
                let (profileResult, bikeResult) = await (hasProfile, hasBike)
                
                if profileResult && bikeResult {
                    print("si hay moto y perfil")
                    
                    if userBikeVM.userBike?.gpsId != nil {
                        let isSuccessLogin = await authViewModel.loginPlaspy()
                        if isSuccessLogin {
                           _ = await userBikeVM.getLastLocation()
                        }
                    }
                    
                    authViewModel.status = .authenticated
                } else {
                    print("no hay moto o perfil", profileResult, bikeResult)
                    authViewModel.status = .profileOnboarding
                }
            }
        }
    }
}

#Preview {
    CheckingProfileScreen()
        .environmentObject(AuthViewModel())
        .environmentObject(ProfileViewModel())
        .environmentObject(UserBikesViewModel())
        .environmentObject(MainRouter())
}
