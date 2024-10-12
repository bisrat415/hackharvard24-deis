//
//  SearchBarView.swift
//  UniRoute
//
//  Created by Kevin Cui on 10/12/24.
//

import SwiftUI

struct SearchBarView: View {
    
    @State var searchText: String = ""
    @State var username: String = "Isaac Park"
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack{
                Text("Welcome")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
                Text(username)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 20)
            HStack {
                TextField("Where do you want to go?", text: $searchText)
                    .padding(.leading, 10)
                    .font(.system(size: 18, weight: .medium))
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.secondary)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue.opacity(0.8))
                            .frame(width: 45, height: 45)
                    )
            }
            .font(.headline)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1),radius: 5, x: 0, y: 2) // Adds light shadow
            )
            .padding(.horizontal, 20)
        }
        .background(
            Image("SearchBarView")
                .resizable()
                .scaledToFill() // Ensure the image fills the space
                .frame(height: 240)
                .clipped()
        )
        
    }
    
    
    struct SearchBarView_Previews: PreviewProvider {
        static var previews: some View {
            SearchBarView()
        }
    }
}


