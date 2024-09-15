//
//  ProfileView.swift
//  CultureTap
//
//  Created by Henry's Mac on 9/14/24.
//

import SwiftUI

struct ProfileView: View {
    @State private var selectedCountry = "USA"
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
                Text("CULTURETAP")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Select your Country")
                    .foregroundColor(.white)
                    .font(.headline)
                
                HStack {
                    Text("USA")
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(8)
            }
            .padding(.horizontal)
            
            Spacer()
            
            Button(action: {
                // Action for Next button
                print("Next button tapped")
            }) {
                Text("Next")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.mint)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    ProfileView()
}
