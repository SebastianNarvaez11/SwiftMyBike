//
//  TextModifier.swift
//  WordyCards
//
//  Created by Sebastian on 10/08/24.
//

import SwiftUI

struct TextModifier: ViewModifier {
    
    let font : Fonts
    let size : CGFloat
    let color : Color
    
    func body(content: Content) -> some View {
        content
            .font(.custom(font.rawValue, size: size))
            .foregroundStyle(color)
    }
}

extension View {
    func typography(_ font: Fonts = .regular, _ size: CGFloat = 16, _ color: Color = .defaultText) -> some View {
        modifier(TextModifier(font: font, size: size, color: color))
    }
}

#Preview {
    Text("Hola Mundo").typography(.bold, 35)
}
