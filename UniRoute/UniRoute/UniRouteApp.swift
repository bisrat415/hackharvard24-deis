//
//  UniRouteApp.swift
//  UniRoute
//
//  Created by Bisrat Kassie on 10/11/24.
//

import SwiftUI
import SwiftData

@main
struct UniRouteApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var showLaunchScreen = true
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([Item.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            if showLaunchScreen {
                LaunchScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            withAnimation {
                                showLaunchScreen = false
                            }
                        }
                    }
            } else {
                ContentView()
                    .modelContainer(sharedModelContainer)
            }
        }
    }
}
