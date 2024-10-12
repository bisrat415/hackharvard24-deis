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
                    print("Home Button tapped")
                }) {
                    HStack {
                        Image(systemName: "house.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("Home")
                            .font(.headline)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .resizable()
                            .frame(width: 10, height: 16)
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
                Button(action: {
                    print("University Button tapped")
                }) {
                    HStack {
                        Image(systemName: "building.2.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("University")
                            .font(.headline)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .resizable()
                            .frame(width: 10, height: 16)
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
                Button(action: {
                    print("Work Button tapped")
                }) {
                    HStack {
                        Image(systemName: "briefcase.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("Work")
                            .font(.headline)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .resizable()
                            .frame(width: 10, height: 16)
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
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


    

