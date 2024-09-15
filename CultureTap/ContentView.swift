//
//  ContentView.swift
//  CultureTap
//
//  Created by Henry's Mac on 9/14/24.
//

import SwiftUI

struct ContentView: View {
    @State private var id: String = ""
    @State private var password: String = ""
    
    var body: some View {
            VStack {
                Spacer()
                
                Image("Logo")
                    .resizable()
                    .frame(width: 320, height: 100)
                    .padding()
                
                TextField("ID", text: $id)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: {
                    print("Sign Up Button Pressed")
                }) {
                    Text("Sign Up")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.keyColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                Spacer()
            }
            .padding()
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

