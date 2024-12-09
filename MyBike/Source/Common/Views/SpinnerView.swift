//
//  SpinnerView.swift
//  WordyCards
//
//  Created by Sebastian on 25/08/24.
//

import SwiftUI

struct SpinnerView: View {
    
    @State var isAppearing: Bool = false
    var size: Double = 20
    var color: Color = .accent
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(lineWidth: 5)
                .frame(width: size, height: size)
                .foregroundStyle(Color(.systemGray5) .opacity(0.5))
            
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(lineWidth: 5)
                .frame(width: size, height: size)
                .foregroundStyle(color)
                .rotationEffect(.degrees(isAppearing ? 360: 0), anchor: .center)
                .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: isAppearing)
        }.onAppear(){
            isAppearing = true
        }
    }
}

#Preview {
    SpinnerView(size:20)
}
