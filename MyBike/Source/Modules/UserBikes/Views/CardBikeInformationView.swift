//
//  CardBikeInformationView.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 24/12/24.
//

import SwiftUI

struct CardBikeInformationView: View {
    
    var icon: String
    var title: String
    var value: String
    
    var body: some View {
        VStack(){
            HStack{
                Spacer()
                
                Image(systemName: icon)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 23, height: 23)
            }
            .padding(.top, 20)
            .padding(.trailing, 20)
            
            Spacer()
            
            HStack{
                VStack(alignment: .leading, spacing: 5){
                    Text(title).typography(.regular, 12).multilineTextAlignment(.leading)
                    
                    Text(value).typography(.bold, 18).lineLimit(1)
                }
                
                Spacer()
            }.padding(10)
            
        }
        .frame(width: 120, height: 130)
        .background(.backgroundPrimary)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    CardBikeInformationView(icon: "drop.fill", title: "Cambio de aceite", value: "29/10/2025")
}
