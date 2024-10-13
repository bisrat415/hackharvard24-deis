import SwiftUI

struct FavoritePlace: Identifiable {
    var id: UUID = UUID()
    var name: String
    var latitude: Double
    var longitude: Double
}

struct FavoriteView: View {
    // Hardcoded array of 3 favorite places
    let favoritePlaces: [FavoritePlace] = [
        FavoritePlace(name: "Newbury St", latitude: 42.248817, longitude: -71.085428),
        FavoritePlace(name: "Harvard University", latitude: 42.785091, longitude: -71.968285),
        FavoritePlace(name: "Brandeis University", latitude: 41.689247, longitude: -73.044502),
        FavoritePlace(name: "Boston Public Library", latitude: 42.248817, longitude: -71.085428),
        FavoritePlace(name: "New England Aquarium", latitude: 41.62417, longitude: -71.64428),
    ]

    var body: some View {
        NavigationView {
            List(favoritePlaces) { place in
                VStack(alignment: .leading) {
                    Text(place.name)
                        .font(.headline)
                    Text("\(place.latitude), \(place.longitude)")
                        .font(.subheadline)
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
