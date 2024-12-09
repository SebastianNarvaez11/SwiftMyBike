//
//  AuthHeaderView.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 5/11/24.
//

import SwiftUI

struct AuthHeaderView: View {
    
    var title: String = ""
    var size: CGFloat = 35
    var body: some View {
        VStack(spacing: 50){
            HStack{
                Image("icon")
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { size, axis in
                        size * 0.15
                    }
                
                Text("MyBike").typography(.bold, size)
            }
            
            
            HStack{
                Text(title).typography(.regular, 20)
                
                Spacer()
            }
        }
        
        
    }
}

#Preview {
    AuthHeaderView()
}
