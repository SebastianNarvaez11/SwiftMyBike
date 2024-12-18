//
//  AsyncImageView.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 15/12/24.
//

import SwiftUI

struct AsyncImageView: View {
    
    @StateObject var mediaVM = MediaViewModel()
    
    let imageKey: String?
    @State var signedUrl: String?
    
    var body: some View {
        VStack{
            if let url = signedUrl {
                AsyncImage(url: URL(string: url)){ phase in
                    switch phase {
                    case .empty:
                        ProgressView() // Muestra un cargador mientras la imagen se carga
                    case .success(let image):
                        image.resizable() // Imagen cargada exitosamente
                            .scaledToFill()
                    case .failure:
                        Text("Error loading image") // Error si no se puede cargar la imagen
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            
        }
        .frame(width: 100, height: 100)
        .background(Color(.systemGray4))
         .onAppear(){
            Task{
                guard let imageKey = imageKey else { return }
                
                if let url = await mediaVM.getSignedUrl(imageKey: imageKey) {
                    signedUrl = url
                }
            }
        }
        
    }
}

#Preview {
    AsyncImageView(imageKey: "")
}
