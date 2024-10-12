//
//  ContentView.swift
//  UniRoute
//
//  Created by Bisrat Kassie on 10/11/24.
//

import SwiftUI

struct ContentView: View {
  
    var body: some View {
        VStack {
            SearchBarView()

            Spacer()
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(0)

                FavoriteView()
                    .tabItem {
                        Label("Favorites", systemImage: "star.fill")
                    }
                    .tag(1)
                
                NearbyView()
                    .tabItem {
                        Label("Nearby", systemImage: "location.circle")
                    }
                    .tag(2)

                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
                    .tag(3)
            }
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
