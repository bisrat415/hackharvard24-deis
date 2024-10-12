//
//  MapView.swift
//  UniRoute
//
//  Created by Sherren Jie on 10/12/24.
//


import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var viewModel = MapViewModel()
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                viewModel.checkLocationServiceEnabled()
            }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 42.3601, longitude: -71.0589),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var locationManager: CLLocationManager?
    
    func checkLocationServiceEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("Location is Off. Please turn on!")
        }
    }
    
    private func checkLocationAuthorization() {
        switch locationManager?.authorizationStatus {
            case .notDetermined:
                locationManager?.requestWhenInUseAuthorization()
            case .denied, .restricted:
                print("Location Permissions are Off. Go into settings to turn it on. ")
        case .authorizedAlways,.authorizedWhenInUse:
            region = MKCoordinateRegion(
                center: (locationManager?.location!.coordinate)!,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            default:
                break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}

//
//import SwiftUI
//import GoogleMaps
//
//struct MapView: UIViewRepresentable {
//    
//    @ObservedObject var locationManager = LocationManager()
//    
//    func makeUIView(context: Context) -> GMSMapView {
//        let camera = GMSCameraPosition.camera(withLatitude: locationManager.lastLocation?.latitude ?? -33.86, longitude: locationManager.lastLocation?.longitude ?? 151.20, zoom: 15.0)
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        mapView.isMyLocationEnabled = true // Show the user's location on the map
//        return mapView
//    }
//    
//    func updateUIView(_ mapView: GMSMapView, context: Context) {
//        if let location = locationManager.lastLocation {
//            mapView.animate(toLocation: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
//        }
//    }
//}


