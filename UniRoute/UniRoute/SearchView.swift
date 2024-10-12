//
//  SearchView.swift
//  UniRoute
//
//  Created by Sherren Jie on 10/12/24.
//
import SwiftUI
import MapKit

struct RouteStep: Identifiable {
    let id = UUID()
    let title: String
    let details: String
    let arrivalTime: String
    let duration: Int 
    let cost: Double
}
let hardcodedRoutes = [
    RouteStep(title: "Usdan Student Center", details: "Brandeis University Shuttle", arrivalTime: "Arrives in 8 min", duration: 10, cost: 0.0),
    RouteStep(title: "Hynes Convention Center Station", details: "Nubian", arrivalTime: "Arrives in 2 min", duration: 5, cost: 1.5),
    RouteStep(title: "Massachusetts Ave", details: "Red Line", arrivalTime: "Arrives 15 mins", duration: 20, cost: 2.5)
]

extension Collection where Element == RouteStep {
    var totalTime: Int {
        self.reduce(0) { $0 + $1.duration }
    }

    var totalCost: Double {
        self.reduce(0) { $0 + $1.cost }
    }
}

struct SearchView: View {
    @ObservedObject var locationManager = LocationManager()
    @ObservedObject var completer = LocationCompleter()

    @State private var departure: String = ""
    @State private var destination: String = ""
    @State private var showRoutes: Bool = false
    @State private var activeField: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            TextField("Enter departure", text: $departure, onEditingChanged: { isEditing in
                activeField = isEditing ? "departure" : ""
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .onChange(of: departure) { newValue in
                completer.updateQueryFragment(newValue)
            }

            TextField("Enter destination", text: $destination, onEditingChanged: { isEditing in
                activeField = isEditing ? "destination" : ""
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .onChange(of: destination) { newValue in
                completer.updateQueryFragment(newValue)
            }

            Button("Go") {
                showRoutes = !departure.isEmpty && !destination.isEmpty
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(8)
            .padding(.horizontal)
            
            if showRoutes {
                VStack(alignment: .leading) {
                    Text("Total Time: \(hardcodedRoutes.totalTime) mins").bold()
                    Text("Total Cost: $\(hardcodedRoutes.totalCost, specifier: "%.2f")").bold()
                }
                .padding(.bottom)
                
                List(hardcodedRoutes) { route in
                    VStack(alignment: .leading) {
                        Text(route.title).bold()
                        Text(route.details)
                        Text(route.arrivalTime)
                        Text("Duration: \(route.duration) mins").padding(.top, 1)
                        Text("Cost: $\(route.cost, specifier: "%.2f")").padding(.top, 1)
                    }
                }
            }

            // Display autocomplete results
            if !activeField.isEmpty {
                List(completer.searchResults, id: \.self) { result in
                    Text(result.title).onTapGesture {
                        if activeField == "departure" {
                            departure = result.title
                        } else if activeField == "destination" {
                            destination = result.title
                        }
                        activeField = ""  // Clear active field
                    }
                }
            }
        }
        .padding()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

class LocationCompleter: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    @Published var searchResults = [MKLocalSearchCompletion]()
    private var completer = MKLocalSearchCompleter()

    override init() {
        super.init()
        completer.delegate = self
        completer.resultTypes = .address // Customize this as needed
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
