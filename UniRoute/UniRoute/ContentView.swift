//
//  ContentView.swift
//  UniRoute
//
//  Created by Bisrat Kassie on 10/11/24.
//

import SwiftUI

struct ContentView: View {
    init() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor(hex: "#2EAF37")
        
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = .white
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = .yellow
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.yellow]
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
        
    var body: some View {
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
