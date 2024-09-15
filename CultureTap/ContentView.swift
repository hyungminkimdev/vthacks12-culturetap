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
    @StateObject var userprofile = UserProfile(name: "", age: 0, country: "", hobbies: "", mbti: "", funFacts: "")

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image("Logo")
                    .resizable()
                    .frame(width: 320, height: 100)
                    .padding()
                
                Spacer()
                    .frame(height: 60)
                
                TextField("ID", text: $id)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .textInputAutocapitalization(.never)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .textInputAutocapitalization(.never)
                
                Spacer()
                    .frame(height: 20)
                
                NavigationLink(destination: ProfileView(userprofile: userprofile)) {
                    Text("Sign Up")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.keyColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Text("OR")
                    .font(.title3)
                    .foregroundStyle(Color.white)
                    .padding(.top, 10)
                
                NavigationLink(destination: ProfileView(userprofile: userprofile)) {
                    Image("SignUpApple")
                        .resizable()
                        .frame(width: 350, height: 60)
                        .padding(.horizontal)
                }
                
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
}

//#Preview {
//    ContentView()
//}

