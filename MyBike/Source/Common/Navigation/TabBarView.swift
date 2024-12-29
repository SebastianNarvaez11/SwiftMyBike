//
//  TabBarView.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 24/12/24.
//

import SwiftUI

enum Tabs {
    case home
    case map
    case profile
}

struct TabBarView: View {
    @State var seletedTab: Tabs = .home
    
    var body: some View {
        ZStack{
            switch seletedTab {
            case .map:
                MapScreen()
                    .transition(.push(from: .leading))
            case .home:
                HomeScreen()
                    .transition(.push(from: .bottom))
            case .profile:
                ProfileScreen()
                    .transition(.push(from: .trailing))
            }
            
            BottomTabBarView(seletedTab: $seletedTab)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            
        }
        .background(.backgroundSecondary)
        .ignoresSafeArea(edges: .bottom)
    }
}


#Preview {
    TabBarView()
        .environmentObject(AuthViewModel())
        .environmentObject(ProfileViewModel())
        .environmentObject(UserBikesViewModel())
        .environmentObject(MainRouter())
}
