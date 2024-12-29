//
//  ProfileScreen.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 6/11/24.
//

import SwiftUI

struct ProfileScreen: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        ScreenLayout(spacing:10){
            Text("ProfileScreen")
            
            ButtonView(label: "Cerrar sesion", action: {authVM.logout()})
        }
    }
}

#Preview {
    ProfileScreen()
        .environmentObject(AuthViewModel())
}
