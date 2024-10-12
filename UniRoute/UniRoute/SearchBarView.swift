//
//  SearchBarView.swift
//  UniRoute
//
//  Created by Kevin Cui on 10/12/24.
//

import SwiftUI

struct SearchBarView: View {
    
    @State var searchText: String = ""
    
    var body: some View {
        HStack {
            TextField("Where do you want to go?", text: $searchText)
                .padding(.leading, 10)
                .font(.system(size: 18, weight: .medium))
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.secondary)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.black.opacity(0.3))
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
    
    
    struct SearchBarView_Previews: PreviewProvider {
        static var previews: some View {
            SearchBarView()
        }
    }
}


