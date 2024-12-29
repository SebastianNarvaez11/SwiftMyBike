//
//  LocationViewModel.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 28/12/24.
//

import Foundation
import CoreLocation

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var showPermissionDeniedAlert: Bool = false
    
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        // Solicita permiso para usar la ubicación
        self.locationManager.requestWhenInUseAuthorization()
        // Intenta empezar a actualizar la ubicación si ya está autorizado
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        // Actualiza la ubicación del usuario
        userLocation = location.coordinate
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            // Permisos aún no solicitados
            break
        case .restricted, .denied:
            // Usuario rechazó permisos o está restringido (por control parental, etc.)
            handlePermissionDenied()
        case .authorizedWhenInUse, .authorizedAlways:
            // Usuario otorgó permisos
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    func handlePermissionDenied() {
        DispatchQueue.main.async {
            // Mostrar una alerta o redirigir al usuario
            self.showPermissionDeniedAlert = true
        }
    }
}
