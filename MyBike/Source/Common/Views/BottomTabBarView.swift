//
//  BottomTabBarView.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 22/12/24.
//

import SwiftUI

struct BottomTabBarView: View {
    @Binding var seletedTab: Tabs
    
    var body: some View {
        VStack{
            Spacer()
            
            HStack(){
                Spacer()
                Image(systemName: "map")
                    .font(.system(size: 25))
                    .foregroundStyle(.defaultText)
                    .onTapGesture {
                        withAnimation(){
                            seletedTab = .map
                        }
                    }
                
                
                Spacer()
                Image(systemName: "house")
                    .font(.system(size: 25))
                    .foregroundStyle(.defaultText)
                    .onTapGesture {
                        withAnimation(){
                            seletedTab = .home
                        }
                    }
                
                Spacer()
                
                Image(systemName: "person")
                    .font(.system(size: 25))
                    .foregroundStyle(.defaultText)
                    .onTapGesture {
                        withAnimation(){
                            seletedTab = .profile
                        }
                    }
                
                Spacer()
            }
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .foregroundStyle(.backgroundPrimary)
                    .shadow(color:.black.opacity(0.2),radius: 10)
            )
        }
    }
}

#Preview {
    BottomTabBarView(seletedTab: .constant(.home))
}
