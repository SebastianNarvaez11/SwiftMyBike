//
//  createMapRegion.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 28/12/24.
//

import Foundation
import SwiftUI
import MapKit

func createMapRegion(for coordinates: [CLLocationCoordinate2D], padding: Double = 0.005) -> MKCoordinateRegion? {
    guard !coordinates.isEmpty else { return nil }
    
    var minLat = coordinates.first!.latitude
    var maxLat = coordinates.first!.latitude
    var minLon = coordinates.first!.longitude
    var maxLon = coordinates.first!.longitude
    
    for coordinate in coordinates {
        minLat = min(minLat, coordinate.latitude)
        maxLat = max(maxLat, coordinate.latitude)
        minLon = min(minLon, coordinate.longitude)
        maxLon = max(maxLon, coordinate.longitude)
    }
    
    let center = CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2, longitude: (minLon + maxLon) / 2)
    let latitudeDelta = (maxLat - minLat) + padding
    let longitudeDelta = (maxLon - minLon) + padding
    
    return MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta))
}
