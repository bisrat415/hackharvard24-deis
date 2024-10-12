//
//  SearchView.swift
//  UniRoute
//
//  Created by Sherren Jie on 10/12/24.
//
import SwiftUI
import MapKit

struct IdentifiableMapItem: Identifiable {
    let id = UUID()
    let mapItem: MKMapItem
}

struct SearchView: View {
    @ObservedObject var locationManager = LocationManager()
    @ObservedObject var completer = LocationCompleter()
    @State private var places: [IdentifiableMapItem] = []

    @State private var departure: String = ""
    @State private var destination: String = ""
    
    @State private var selectedDeparture: MKMapItem? = nil
    @State private var selectedDestination: MKMapItem? = nil

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    TextField("Enter departure", text: $departure)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: departure) { newValue in
                            completer.updateQueryFragment(newValue)
                        }
                    
                    TextField("Enter destination", text: $destination)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: destination) { newValue in
                            completer.updateQueryFragment(newValue)
                        }
                }
                .padding()

                Button(action: {
                    calculateRoute()
                }) {
                    Text("Go")
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            
            List(completer.searchResults, id: \.self) { completion in
                Text(completion.title)
                    .onTapGesture {
                        // Handling selection
                        searchMap(completion: completion)
                    }
            }

            Map(coordinateRegion: $locationManager.region, showsUserLocation: true, annotationItems: places) { place in
                MapMarker(coordinate: place.mapItem.placemark.coordinate, tint: .red)
            }
            .cornerRadius(10)
            .padding()
        }
        .onAppear {
            locationManager.start()
        }
        .onDisappear {
            locationManager.stop()
        }
    }

    func searchMap(completion: MKLocalSearchCompletion) {
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            if let response = response {
                let newPlaces = response.mapItems.map { IdentifiableMapItem(mapItem: $0) }
                self.places = newPlaces
                
                // Store the first item as either the departure or destination
                if departure.isEmpty {
                    self.selectedDeparture = response.mapItems.first
                } else {
                    self.selectedDestination = response.mapItems.first
                }
                
                if let firstItem = response.mapItems.first {
                    locationManager.region.center = firstItem.placemark.coordinate
                }
            } else if let error = error {
                print("Error occurred: \(error.localizedDescription)")
            }
        }
    }

    func calculateRoute() {
        guard let source = selectedDeparture, let destination = selectedDestination else {
            print("Departure or destination not set")
            return
        }

        let request = MKDirections.Request()
        request.source = source
        request.destination = destination
        request.transportType = .automobile

        let directions = MKDirections(request: request)
        directions.calculate { (response, error) in
            if let route = response?.routes.first {
                locationManager.region = MKCoordinateRegion(route.polyline.boundingMapRect)
            } else if let error = error {
                print("Couldn't calculate route: \(error.localizedDescription)")
            }
        }
    }
}

class LocationCompleter: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    @Published var searchResults = [MKLocalSearchCompletion]()
    private var completer: MKLocalSearchCompleter
    
    override init() {
        completer = MKLocalSearchCompleter()
        super.init()
        completer.delegate = self
    }
    
    func updateQueryFragment(_ fragment: String) {
        completer.queryFragment = fragment
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

