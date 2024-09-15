//
//  LoadingView.swift
//  CultureTap
//
//  Created by Harditya Sarvaiya on 9/15/24.
//

import SwiftUI

struct LoadingView: View {
    @State private var navigateToPeerData = false

    var body: some View {
        NavigationView {
            ZStack {
                // Set the background color to black
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Connecting...")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .mint))
                        .scaleEffect(2) // Adjusts the size of the progress indicator
                        .padding()
                }
                
                // NavigationLink to PeerDataView
                NavigationLink(destination: PeerDataView(), isActive: $navigateToPeerData) {
                    EmptyView()
                }
            }
            .onAppear {
                // Trigger navigation after 6 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                    self.navigateToPeerData = true
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    LoadingView()
}
