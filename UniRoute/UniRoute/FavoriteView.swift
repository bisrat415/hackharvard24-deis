//
//  FavoriteView.swift
//  UniRoute
//
//  Created by Sherren Jie on 10/12/24.
//
import SwiftUI

struct FavoritePlace: Codable, Identifiable {
    var id: UUID = UUID()
    var name: String
    var latitude: Double
    var longitude: Double
}

class FavoritesManager: ObservableObject {
    @Published var places: [FavoritePlace] = []
    private let favoritesKey = "favorites"

    init() {
        loadFavorites()
    }

    func addFavorite(_ place: FavoritePlace) {
        places.append(place)
        saveFavorites()
    }

    func removeFavorite(at offsets: IndexSet) {
        places.remove(atOffsets: offsets)
        saveFavorites()
    }

    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(places) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }

    private func loadFavorites() {
        if let savedItems = UserDefaults.standard.data(forKey: favoritesKey),
           let decodedItems = try? JSONDecoder().decode([FavoritePlace].self, from: savedItems) {
            places = decodedItems
        }
    }
}
struct FavoriteView: View {
    @StateObject var favoritesManager = FavoritesManager()

    var body: some View {
        NavigationView {
            List {
                ForEach(favoritesManager.places) { place in
                    VStack(alignment: .leading) {
                        Text(place.name)
                            .font(.headline)
                        Text("\(place.latitude), \(place.longitude)")
                            .font(.subheadline)
                    }
                }
                .onDelete(perform: favoritesManager.removeFavorite)
            }
            .navigationTitle("Favorites")
            .toolbar {
                EditButton()
            }
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}

