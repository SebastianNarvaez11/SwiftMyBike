//
//  HomeScreen.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 6/11/24.
//

import SwiftUI

struct HomeScreen: View {
    
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        ScreenLayout(spacing:10){
            ButtonView(label: "check status", action: {
                //                Task{
                //                    await authViewModel.checkStatus()
                //                }
            })
            
            ButtonView(label: "salir", action: {
                
                //                authViewModel.logout()
            })
        }
    }
}

#Preview {
    HomeScreen().environmentObject(AuthViewModel())
}
