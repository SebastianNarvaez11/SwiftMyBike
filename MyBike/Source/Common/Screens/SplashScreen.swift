//
//  SplashScreen.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 5/11/24.
//

import SwiftUI

struct SplashScreen: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
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
                await authViewModel.checkAuthStatus()
            }
        }
    }
}

#Preview {
    SplashScreen().environmentObject(AuthViewModel())
}
