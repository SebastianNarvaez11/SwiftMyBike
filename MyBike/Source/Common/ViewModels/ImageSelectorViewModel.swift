//
//  ImageSelectorViewModel.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 14/12/24.
//

import Foundation
import SwiftUI
import PhotosUI

struct SelectedImage {
    let image: UIImage
    let ext: String
    let data: Data
}


class ImageSelectorViewModel: ObservableObject {
    @Published var images = [SelectedImage]()
    @Published var selectedPhotos = [PhotosPickerItem]() {
        didSet {
            Task { await convertDataToImage() }
        }
    }
    
    @MainActor
    private func convertDataToImage() async {
        images.removeAll()
        
        for item in selectedPhotos {
            if let ext = item.supportedContentTypes.first?.preferredFilenameExtension {
                if let imageData = try? await item.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: imageData) {
                        print(ext)
                        images.append(SelectedImage(image: image, ext: ext, data: imageData))
                    }
                }
            }
            
        }
    }
}
