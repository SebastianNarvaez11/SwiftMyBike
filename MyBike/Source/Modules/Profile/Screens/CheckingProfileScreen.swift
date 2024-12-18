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
    @EnvironmentObject var router: MainRouter
    
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
                guard let user = authViewModel.user else {
                    return 
                }
                
                let hasProfile = await profileViewModel.hasProfile(userId: user.id)
                
                if (hasProfile){
                    authViewModel.status = .authenticated
                } else {
                    router.navigateTo(route: .profileOnboarding)
                }
            }
        }
    }
}

#Preview {
    CheckingProfileScreen()
        .environmentObject(AuthViewModel())
        .environmentObject(ProfileViewModel())
        .environmentObject(MainRouter())
    
}
