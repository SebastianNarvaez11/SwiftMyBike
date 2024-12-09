//
//  ApplicationSwitcher.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 4/11/24.
//

import SwiftUI

struct ApplicationSwitcher: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        switch authViewModel.status {
        case .authenticated:
            MainRouterView{
                HomeScreen()
            }
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
