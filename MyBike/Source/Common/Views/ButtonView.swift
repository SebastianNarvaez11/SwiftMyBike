//
//  ButtonView.swift
//  MyBike
//
//  Created by Sebastian on 25/08/24.
//

import SwiftUI

struct ButtonView: View {
    var label:String
    var isOutline:Bool = false
    var isLoading: Bool = false
    var disabled: Bool = false
    var action: () -> Void
    
    var body: some View {
        if(isOutline){
            Button(action: {
                guard !isLoading && !disabled else { return }
                action()
            }){
                if(isLoading){
                    HStack{
                        SpinnerView()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(disabled ? Color(.systemGray4) : .accent)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }else{
                    Text(label)
                        .typography(.bold, 15, .accent)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2))
                }
            }
        }else{
            Button(action: {
                guard !isLoading && !disabled else { return }
                action()
            }){
                if(isLoading){
                    HStack{
                        SpinnerView(color:.white)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(disabled ? Color(.systemGray4) : .accent)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }else{
                    Text(label)
                        .typography(.bold, 15, .white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(disabled ? Color(.systemGray4) : .accent)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
    }
}

#Preview {
    ButtonView(label: "Ingresar", isOutline: false, action: {})
}
