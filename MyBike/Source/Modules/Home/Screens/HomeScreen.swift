//
//  HomeScreen.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 6/11/24.
//

import SwiftUI

struct HomeScreen: View {
    
    @EnvironmentObject var authVM : AuthViewModel
    @EnvironmentObject var profileVM: ProfileViewModel
    
    @State var image: String?
    
    var body: some View {
        ScreenLayout(spacing:10){
            
            AsyncImageView(imageKey: profileVM.profile?.imageKey)
                .clipShape(Circle())
            
            ButtonView(label: "check status", action: {
                Task{
                    await authVM.checkAuthStatus()
                }
            })
            
            ButtonView(label: "salir", action: {
                authVM.logout()
            })
        }
    }
}

#Preview {
    HomeScreen()
        .environmentObject(AuthViewModel())
        .environmentObject(ProfileViewModel())
}
