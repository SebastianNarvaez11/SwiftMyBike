//
//  MapScreen.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 24/12/24.
//

import SwiftUI
import MapKit

struct MapScreen: View {
    
    @EnvironmentObject var userBikeVM: UserBikesViewModel
    
    @StateObject var locationVM = LocationViewModel()
    
    @AppStorage("lastBikeLatitude") var lastBikeLatitude: Double = 4.570868
    @AppStorage("lastBikeLongitude") var lastBikeLongitude: Double = -74.297333
    
    @State var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var body: some View {
        ZStack{
            Map(position: $position){
                //marker del usuario
                UserAnnotation()
                
                //marker de la moto
                if let userBike = userBikeVM.userBike {
                    if let location = userBikeVM.lastLocation {
                        Annotation(userBike.bike.model, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)){
                            AsyncImageView(signedUrl: userBike.bike.signedUrl, width: 50, height: 50)
                        }
                    }
                    
                }
            }
            
            VStack{
                Spacer()
                
                HStack{
                    MapOptionView(image: "person.fill", action: { moveCameraToUserLocation() })
                    MapOptionView(image: "motorcycle.fill", action: { moveCameraToBikeLocation() })
                    if (locationVM.userLocation != nil) {
                        MapOptionView(image: "arrow.up.backward.and.arrow.down.forward.square", action: { moveCameraToFitUserAndBike() })
                    }
                }
            }.padding(.bottom, 100)
        }
        .alert(isPresented: $locationVM.showPermissionDeniedAlert){
            Alert(
                title: Text("Algo salio mal"),
                message: Text("No podemos acceder a tu ubicacion, ve a la configuracion de la app y activa los permisos de localizacion"))
        }
        .onAppear(){
            //mover a la ultima ubicacion guardada en storage
            moveCameraToLastKnowBikeLocation()
            
            //solicitar un ubicacion actualizada y actualizarla tambien en el storage
            Task{
               await moveCameraToNewBikeLocation()
            }
        }
    }
    
    func moveCameraToLastKnowBikeLocation() -> Void {
        withAnimation(){
            position = createMapCameraPosition(latitude:lastBikeLatitude, longitude: lastBikeLongitude)
        }
    }
    
    func moveCameraToUserLocation() -> Void {
        if let userLocation = locationVM.userLocation {
            withAnimation(){
                position = createMapCameraPosition(latitude: userLocation.latitude, longitude: userLocation.longitude, zoom: 0.01)
            }
        }
    }
    
    func moveCameraToBikeLocation() -> Void {
        if let bikeLocation = userBikeVM.lastLocation {
            withAnimation(){
                position = createMapCameraPosition(latitude: bikeLocation.latitude, longitude: bikeLocation.longitude, zoom: 0.001)
            }
        }
    }
    
    func moveCameraToNewBikeLocation() async -> Void {
        if let location = await userBikeVM.getLastLocation() {
            withAnimation(){
                position = createMapCameraPosition(latitude: location.latitude, longitude: location.longitude)
            }
        }
    }
    
    func moveCameraToFitUserAndBike() {
        if let userLocation = locationVM.userLocation,
           let bikeLocation = userBikeVM.lastLocation {
            
            let coordinates = [
                CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude),
                CLLocationCoordinate2D(latitude: bikeLocation.latitude, longitude: bikeLocation.longitude)
            ]
            
            if let region = createMapRegion(for: coordinates) {
                withAnimation {
                    position = .region(region)
                }
            }
        }
    }

}

#Preview {
    MapScreen()
        .environmentObject(UserBikesViewModel())
}
