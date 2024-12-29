//
//  ProfileImageView.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 21/12/24.
//

import SwiftUI

struct ProfileImageView: View {
    @EnvironmentObject var profileVM: ProfileViewModel
    
    @State var image: String?
    var width: CGFloat?
    var height: CGFloat?
    
    var body: some View {
        AsyncImageView(signedUrl: image, width: width ?? 100, height: height ?? 100)
            .background(Color(.systemGray4))
            .clipShape(Circle())
            .onAppear(){
                Task{
                    if let url = await profileVM.getSignedProfileUrl(){
                        image = url
                    }
                }
            }
    }
}

#Preview {
    ProfileImageView().environmentObject(ProfileViewModel())
}
