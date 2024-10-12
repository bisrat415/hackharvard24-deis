//
//  HomeView.swift
//  UniRoute
//
//  Created by Sherren Jie on 10/12/24.
//

import SwiftUI
import MapKit

struct HomeView: View {

    var body: some View {
        VStack {
            SearchBarView()
            MapView()

            VStack(alignment: .leading, spacing: 10) {
                Text("Favorites")
                    .bold()
                
                Button(action: {
                    // Add your action here
                    print("Button tapped")
                }) {
                    HStack {
                        Image(systemName: "house.fill") 
                            .resizable()
                            .frame(width: 24, height: 24) // Set the size of the icon
                        Text("Home") // Add the text next to the home icon
                                .font(.headline) // Optional: Adjust font style if needed
                        Spacer()
                        Image(systemName: "chevron.right") // Replace "$2.17" with a right arrow
                                        .resizable()
                                        .frame(width: 10, height: 16) // Set the size of the caret arrow
                    }
                    .padding()
                    .background(Color.blue) // Add a background color to make it look more like a button
                    .foregroundColor(.white) // Set text color
                    .cornerRadius(10) // Optional: round the corners of the button
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
    

