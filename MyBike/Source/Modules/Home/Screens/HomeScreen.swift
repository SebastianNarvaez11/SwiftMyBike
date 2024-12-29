//
//  HomeScreen.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 6/11/24.
//

import SwiftUI
import SDWebImageSwiftUI


struct HomeScreen: View {
    
    @EnvironmentObject var authVM : AuthViewModel
    @EnvironmentObject var profileVM: ProfileViewModel
    @EnvironmentObject var userBikeVM: UserBikesViewModel
    @EnvironmentObject var router: MainRouter
    
    
    var body: some View {
        ScreenLayout(spacing:10, paddingHorizontal: false){
            HStack(alignment: .top){
                VStack(alignment: .leading){
                    Image("icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Text("¡Hola, \(profileVM.profile?.name ?? "Usuario")!").typography(.semiBold, 20)
                }
                
                Spacer()
                
                ProfileImageView(width: 50, height: 50)
                    .onTapGesture {
                        router.navigateTo(route: .settings)
                    }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
            
            HStack{
                Spacer()
                
                VStack(alignment: .trailing){
                    Text(userBikeVM.userBike?.bike.brand.name ?? "Marca").typography(.bold, 20)
                    Text(userBikeVM.userBike?.bike.model ?? "Modelo").typography(.bold, 30)
                }
            }
            .padding(.horizontal, 20)
            
            
            UserBikeImage(signedUrl: userBikeVM.userBike?.bike.signedUrl ?? "https://lmalplciptyqoodqxvof.supabase.co/storage/v1/object/sign/MyBikeBucket/bikes/gsxr150.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJNeUJpa2VCdWNrZXQvYmlrZXMvZ3N4cjE1MC5wbmciLCJpYXQiOjE3MzQ5ODU3MDAsImV4cCI6MTczNTU5MDUwMH0.q6TkRC63v0t6-3di8jnrHvGpqGtIhrzm8wbHtkWAZ6s&t=2024-12-23T20%3A28%3A20.649Z")
            
            
            
            
            ScrollView(.horizontal){
                HStack(spacing:20){
                    CardBikeInformationView(icon: "drop", title: "Cambio de aceite", value: "29/10/24")
                    CardBikeInformationView(icon: "tachometer", title: "Kilometraje", value: "\(formatNumber(userBikeVM.lastLocation?.mileage ?? 0))")
                    CardBikeInformationView(icon: "engine.combustion", title: "Revision", value: "35.000")
                    
                }
                .padding(.leading, 20)
            }
            .scrollIndicators(.hidden)
            .padding(.bottom, 100)
        }
    }
}

#Preview {
    HomeScreen()
        .environmentObject(AuthViewModel())
        .environmentObject(ProfileViewModel())
        .environmentObject(UserBikesViewModel())
        .environmentObject(MainRouter())
}
