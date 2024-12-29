//
//  MapOptionView.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 28/12/24.
//

import SwiftUI

struct MapOptionView: View {
    let image: String
    let action: () -> Void
    
    var body: some View {
        Button(action: { action() }, label: {
            VStack{
                Image(systemName: image)
                    .resizable()
                    .scaledToFill()
                    .foregroundStyle(.defaultText)
                    .padding(2)
                    .frame(width: 30, height: 30)
            }
            .frame(width: 60, height: 60)
            .background(.backgroundPrimary)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color:.black.opacity(0.2),radius: 10)
            
        })
    }
}

#Preview {
    MapOptionView(image: "person.fill", action: {})
}
