//
//  HomeView.swift
//  UniRoute
//
//  Created by Sherren Jie on 10/12/24.
//

import SwiftUI
import MapKit

struct MapViewRepresentable: UIViewRepresentable {
    @ObservedObject var locationManager: LocationManager
    @Binding var region: MKCoordinateRegion

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: true)
    }
}

struct HomeView: View {
    @StateObject var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 42.3601, longitude: -71.0589),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    var body: some View {
        VStack {
            SearchBarView()
            MapViewRepresentable(locationManager: locationManager, region: $region)
                .edgesIgnoringSafeArea(.all)
                .frame(height: 300)

            VStack(alignment: .leading, spacing: 10) {
                Text("Current location: Boston Downtown")
                    .bold()
                
                HStack {
                    Text("35 min")
                    Spacer()
                    Text("$2.17")
                }
                
                Text("Usdan Student Center")
                Spacer()
            }
            .padding()
            .background(Color.green.opacity(0.3))
            .cornerRadius(10)
            .padding()
            
            Spacer()
        }
        .navigationBarTitle("Route Details", displayMode: .inline)
    }
}
    

