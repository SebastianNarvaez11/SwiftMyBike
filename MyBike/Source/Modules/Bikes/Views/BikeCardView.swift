//
//  BikeCardView.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 20/12/24.
//

import SwiftUI

struct BikeCardView: View {
    @StateObject var bikeVM = BikeViewModel()

    
    let bike: BikeModel
    @Binding var selectedBike: BikeModel?
    var currentIndex: Int
    var index: Int
    
    var body: some View {
        GeometryReader { innerView in
            VStack{
                AsyncImageView(signedUrl: bike.signedUrl, width: 150, height: 150)
                Text(bike.model).typography(.bold, 25, (selectedBike?.id == bike.id) ? .white : .black)
            }
            .frame(width: innerView.size.width, height: innerView.size.height)
            .background((selectedBike?.id == bike.id ) ? .accent : .backgroundPrimary)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .opacity(currentIndex == index ? 1 : 0.8)
            .overlay{
                if(selectedBike?.id == bike.id) {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .foregroundStyle(.success)
                        .frame(width: 45, height: 45)
                        .offset(x: innerView.size.width * 0.4, y: innerView.size.height * 0.35)
                }
            }
            .scaleEffect(currentIndex == index ? 1: 0.8)
            .onTapGesture(){
                selectedBike = bike
            }
        }
      
    }
}

#Preview {
    BikeCardView(bike: bikeModels[0], selectedBike: .constant(nil), currentIndex: 0, index: 0)
}
