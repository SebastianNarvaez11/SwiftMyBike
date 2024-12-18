//
//  ApplicationSwitcher.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 4/11/24.
//

import SwiftUI

struct ApplicationSwitcher: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @StateObject var profileViewModel = ProfileViewModel()
    
    var body: some View {
        switch authViewModel.status {
        case .authenticated, .checkingProfile:
            MainRouterView{
                if(authViewModel.status == .checkingProfile){
                    CheckingProfileScreen()
                }else{
                    HomeScreen()
                }
            }.environmentObject(profileViewModel)
            
        case .unauthenticated:
            AuthRouterView{
                LoginScreen()
            }
            
        case .checking:
            SplashScreen()
        }
    }
}

#Preview {
    ApplicationSwitcher().environmentObject(AuthViewModel())
}


