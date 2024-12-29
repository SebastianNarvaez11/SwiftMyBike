//
//  ScreenLayout.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 5/11/24.
//

import SwiftUI

struct ScreenLayout<Content:View>: View {
    
    let content: Content
    var spacing: CGFloat = 0
    var goBack: (() -> Void)?
    var withScroll: Bool? = false
    var paddingHorizontal: Bool = true
    
    init(spacing: CGFloat = 0, withScroll: Bool? = false, paddingHorizontal: Bool = true,  goBack: (() -> Void)? = nil, @ViewBuilder content: () -> Content)  {
        self.spacing = spacing
        self.withScroll = withScroll
        self.paddingHorizontal = paddingHorizontal
        self.content = content()
        self.goBack = goBack
    }
    
    var body: some View {
        VStack(spacing: spacing) {
            if((goBack) != nil){
                HStack{
                    
                    Button(action: { goBack?() }, label: {
                        Image(systemName: "arrow.left.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.accent)
                    })
                    
                    
                    Spacer()
                }
            }
            
            if withScroll! {
                ScrollView {
                    content
                }.scrollIndicators(.hidden)
            } else {
                content
            }
            
            Spacer()
        }
        .padding(.horizontal, paddingHorizontal ? 20 : 0)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.backgroundSecondary)
        .navigationBarBackButtonHidden(true)    }
}


#Preview {
    ScreenLayout(goBack: {print("Back press")}){
        Text("hello world")
    }
}
