//
//  AsyncImageView.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 15/12/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct AsyncImageView: View {
    
    let signedUrl: String?
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        VStack{
            if let url = signedUrl {
                WebImage(url: URL(string: url))
                    .resizable()
                    .indicator(.activity)
                    .scaledToFill()
            }
            
        }
        .frame(width: width, height: height)
        
    }
}

#Preview {
    AsyncImageView(signedUrl: "", width: 100, height: 100)
}
