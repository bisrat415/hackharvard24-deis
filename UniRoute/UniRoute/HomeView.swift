//
//  HomeView.swift
//  UniRoute
//
//  Created by Sherren Jie on 10/12/24.
//
import SwiftUI
import GoogleMaps

struct MapViewRepresentable: UIViewRepresentable {
    @ObservedObject var locationManager: LocationManager

    func makeUIView(context: Context) -> GMSMapView {
        let initialLocation = locationManager.lastLocation ?? CLLocationCoordinate2D(latitude: -33.8688, longitude: 151.2093)
        let camera = GMSCameraPosition.camera(withLatitude: initialLocation.latitude, longitude: initialLocation.longitude, zoom: 15)
        let mapView = GMSMapView(frame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        if let location = locationManager.lastLocation {
            let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: uiView.camera.zoom)
            uiView.animate(to: camera)
        }
    }
}


struct HomeView: View {
    @StateObject var locationManager = LocationManager()

    var body: some View {
        VStack {
            SearchBarView()
            MapViewRepresentable(locationManager: locationManager)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

