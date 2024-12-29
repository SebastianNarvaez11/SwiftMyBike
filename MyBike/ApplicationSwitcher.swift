//
//  ApplicationSwitcher.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 4/11/24.
//

import SwiftUI

struct ApplicationSwitcher: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @StateObject var profileVM = ProfileViewModel()
    @StateObject var userBikeVM = UserBikesViewModel()
    
    var body: some View {
        switch authViewModel.status {
        case .authenticated:
            MainRouterView{
                TabBarView()
            }
            .environmentObject(profileVM)
            .environmentObject(userBikeVM)
            
        case .unauthenticated:
            AuthRouterView{
                LoginScreen()
            }
            
        case .checking:
            SplashScreen() //con face id esto no es necesario porque siempre mostramos la pantalla del login
            
        case .checkingProfile:
            CheckingProfileScreen()
                .environmentObject(profileVM)
                .environmentObject(userBikeVM)
            
            
        case .profileOnboarding:
            OnboardingProfileScreen()
                .environmentObject(authViewModel)
                .environmentObject(profileVM)
                .environmentObject(userBikeVM)
        }
    }
}

#Preview {
    ApplicationSwitcher().environmentObject(AuthViewModel())
}


