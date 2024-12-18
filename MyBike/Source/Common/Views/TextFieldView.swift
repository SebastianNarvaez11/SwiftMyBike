//
//  TextFieldView.swift
//  MyBike
//
//  Created by Sebastian on 25/08/24.
//

import SwiftUI

struct TextFieldView: View {
    
    @Binding var value:String
    
    var label: String
    var placeholder: String
    var hasError: Bool = false
    var errorMessage: String = ""
    
    @State var isSecure: Bool = false
    @State var isShowPassword: Bool = false
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text(label).typography(.bold, 15)
            
            if (isSecure) {
                SecureField(placeholder, text: $value)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding(.horizontal)
                    .frame(height: 45)
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(){
                        ShowPasswordButton(isShowPassword: $isShowPassword, isSecure: $isSecure)
                    }
            } else {
                TextField(placeholder, text: $value)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding(.horizontal)
                    .frame(height: 45)
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(){
                        if(isShowPassword){
                            ShowPasswordButton(isShowPassword: $isShowPassword, isSecure: $isSecure)
                        }
                    }
                
            }
            
            if(hasError){
                Text(errorMessage).typography(.regular, 12, .danger)
            }
        }.padding(.bottom, 10)
    }
}

struct ShowPasswordButton : View {
    @Binding var isShowPassword: Bool
    @Binding var isSecure: Bool

    
    var body: some View {
        HStack {
            Spacer()
            
            Image(systemName: isShowPassword ? "eye" : "eye.slash")
                .font(.system(size: 20))
                .foregroundStyle(.accent)
                .padding(.trailing)
                .onTapGesture {
                    withAnimation(){
                        isShowPassword.toggle()
                        isSecure.toggle()
                    }
                }
            
        }
    }
}

#Preview {
    TextFieldView(value: .constant(""), label: "Tu email", placeholder: "Email", isSecure: true)
}
