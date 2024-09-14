//
//  ContentView.swift
//  CultureTap
//
//  Created by Henry's Mac on 9/14/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
            VStack {
                Text("hi")
                    .foregroundStyle(Color.primary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color.background
                    .ignoresSafeArea()
            }
    }
}

#Preview {
    ContentView()
}
