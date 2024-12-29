//
//  createMapCameraPosition.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 28/12/24.
//

import Foundation
import SwiftUI
import MapKit

func createMapCameraPosition(latitude: CLLocationDegrees, longitude: CLLocationDegrees, zoom: CLLocationDegrees = 0.005) -> MapCameraPosition {
    return MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: zoom, longitudeDelta: zoom)))
}
