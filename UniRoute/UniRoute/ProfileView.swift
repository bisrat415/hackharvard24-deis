//
//  ProfileView.swift
//  UniRoute
//
//  Created by Sherren Jie on 10/12/24.
//
import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            HStack {
                // Profile Image and Name
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .padding(.leading, 20)
                
                VStack(alignment: .leading) {
                    Text("Isaac Park")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("isaacpark@brandeis.edu")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding(.top, 20)
       
            List {
                Button(action: { print("Notification tapped") }) {
                    ProfileOption(icon: "bell.fill", text: "Notification")
                }
                Button(action: { print("Settings tapped") }) {
                    ProfileOption(icon: "gearshape.fill", text: "Settings")
                }
                Button(action: { print("Rate Us tapped") }) {
                    ProfileOption(icon: "star.fill", text: "Rate Us")
                }
                Button(action: { print("Ride history tapped") }) {
                    ProfileOption(icon: "clock.fill", text: "Ride history")
                }
                Button(action: { print("Rewards tapped") }) {
                    ProfileOption(icon: "gift.fill", text: "Rewards")
                }
                Button(action: { print("Payment tapped") }) {
                    ProfileOption(icon: "creditcard.fill", text: "Payment")
                }
                Button(action: { print("Help & Support tapped") }) {
                    ProfileOption(icon: "questionmark.circle.fill", text: "Help & Support")
                }
                Button(action: { print("Legal tapped") }) {
                    ProfileOption(icon: "doc.plaintext.fill", text: "Legal")
                }
            }
            .listStyle(GroupedListStyle())
            
            Spacer()
            HStack {
                Text("New in this Version")
                    .foregroundColor(.gray)
                    .font(.caption)
                Spacer()
                Text("About")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            .padding([.leading, .trailing, .bottom], 20)
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProfileOption: View {
    var icon: String
    var text: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.green)
            Text(text)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
    }
}
