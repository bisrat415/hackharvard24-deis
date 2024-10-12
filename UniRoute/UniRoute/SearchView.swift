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
    @State private var routes: [MKRoute] = []
    
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
            
            // Display autocomplete results and allow selection
            if routes.isEmpty {
                List(completer.searchResults, id: \.self) { completion in
                    Text(completion.title)
                        .onTapGesture {
                            selectLocation(completion: completion)
                        }
                }
            }
            
            // Conditionally display the route details
            if !routes.isEmpty {
                List(routes, id: \.self) { route in
                    Section(header: Text("Route Details")) {
                        Text("Duration: \(route.expectedTravelTime / 60, specifier: "%.0f") minutes")
                        Text("Distance: \(route.distance / 1000, specifier: "%.2f") km")
                        ForEach(route.steps, id: \.self) { step in
                            VStack(alignment: .leading) {
                                Text(step.instructions)
                                Text("Distance: \(step.distance, specifier: "%.0f") meters")
                            }
                        }
                    }
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
    
    func selectLocation(completion: MKLocalSearchCompletion) {
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            if let mapItems = response?.mapItems, let firstItem = mapItems.first {
                DispatchQueue.main.async {
                    if departure.isEmpty {
                        selectedDeparture = firstItem
                        departure = firstItem.name ?? "Unknown Location"
                    } else {
                        selectedDestination = firstItem
                        destination = firstItem.name ?? "Unknown Location"
                    }
                }
            }
        }
    }
    
    func calculateRoute() {
        guard let source = selectedDeparture, let destination = selectedDestination else {
            print("Departure or destination not set")
            return
        }
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: source.placemark.coordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination.placemark.coordinate))
        request.transportType = .transit
        request.requestsAlternateRoutes = true
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let response = response {
                self.routes = response.routes
                DispatchQueue.main.async {
                    // Update UI in main thread if necessary
                }
            } else if let error = error {
                print("Couldn't calculate route: \(error.localizedDescription)")
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

class LocationCompleter: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    @Published var searchResults = [MKLocalSearchCompletion]()
    private var completer: MKLocalSearchCompleter
    
    override init() {
        completer = MKLocalSearchCompleter()
        super.init()
        completer.delegate = self
        completer.resultTypes = .address 
    }
    
    func updateQueryFragment(_ fragment: String) {
        completer.queryFragment = fragment
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        DispatchQueue.main.async {
            self.searchResults = completer.results
        }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}
