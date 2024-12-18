//
//  SelectImageFieldView.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 14/12/24.
//

import SwiftUI
import PhotosUI

struct SelectImageFieldView<Content:View>: View {
    
    let content: Content
    @ObservedObject var imageSelectorVM: ImageSelectorViewModel
    let maxSelectionCount: Int?
    
    init(imageSelectorVM: ImageSelectorViewModel, maxSelectionCount:Int? = 1,  @ViewBuilder content: () -> Content) {
        self.imageSelectorVM = imageSelectorVM
        self.maxSelectionCount = maxSelectionCount
        self.content = content()
    }
    
    var body: some View {
        PhotosPicker(
            selection: $imageSelectorVM.selectedPhotos,
            maxSelectionCount: maxSelectionCount,
            matching: .images,
            photoLibrary: .shared()
        ) {
            content
        }
        
    }
}

#Preview {
    SelectImageFieldView(imageSelectorVM: ImageSelectorViewModel()) {
        Text("foto")
    }
}
