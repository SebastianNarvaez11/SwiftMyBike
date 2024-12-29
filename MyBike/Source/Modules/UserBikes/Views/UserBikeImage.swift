//
//  UserBikeImage.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 23/12/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserBikeImage: View {
    
    let signedUrl: String?
    @State var showComplete: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            if let url = signedUrl {
                WebImage(url: URL(string: url))
                    .resizable()
                    .indicator(.activity)
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: showComplete ? .center : .trailing)
                    .scaleEffect(showComplete ? 0.5 : 1)
                    .animation(.bouncy, value: showComplete)
                    .onTapGesture {
                        showComplete.toggle()
                    }
            }
        }
//        .background(.red)
    }
}

#Preview {
    UserBikeImage(signedUrl: "https://lmalplciptyqoodqxvof.supabase.co/storage/v1/object/sign/MyBikeBucket/bikes/gsxr150.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJNeUJpa2VCdWNrZXQvYmlrZXMvZ3N4cjE1MC5wbmciLCJpYXQiOjE3MzQ5ODU3MDAsImV4cCI6MTczNTU5MDUwMH0.q6TkRC63v0t6-3di8jnrHvGpqGtIhrzm8wbHtkWAZ6s&t=2024-12-23T20%3A28%3A20.649Z")
}
