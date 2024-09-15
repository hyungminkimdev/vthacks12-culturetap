//
//  LoadingView.swift
//  CultureTap
//
//  Created by Harditya Sarvaiya on 9/15/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
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
        }
    }
}


#Preview {
    LoadingView()
}
