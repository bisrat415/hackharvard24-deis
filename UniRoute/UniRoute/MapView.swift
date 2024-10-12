//
//  MapView.swift
//  UniRoute
//
//  Created by Sherren Jie on 10/12/24.
//

import SwiftUI
import GoogleMaps

struct MapView: UIViewRepresentable {
    
    @ObservedObject var locationManager = LocationManager()
    
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: locationManager.lastLocation?.latitude ?? -33.86, longitude: locationManager.lastLocation?.longitude ?? 151.20, zoom: 15.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true // Show the user's location on the map
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        if let location = locationManager.lastLocation {
            mapView.animate(toLocation: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
        }
    }
}

