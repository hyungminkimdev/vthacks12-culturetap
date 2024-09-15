//
//  ProfileView.swift
//  CultureTap
//
//  Created by Henry's Mac on 9/14/24.
//

import SwiftUI

struct ProfileView: View {
    @State private var textInput: String = ""
    @State private var currentStep: Int = 0
    
    let labels = ["Name", "Age", "Country", "Hobbies", "MBTI", "Fun Fact"]
    let placeholders = [
        "Enter your name",
        "Enter your age",
        "Enter your country",
        "Enter your hobbies",
        "Enter your MBTI",
        "Enter a fun fact about you"
    ]

    var body: some View {
        VStack {
            Spacer()
            
            Image("Logo")
                .resizable()
                .frame(width: 320, height: 100)
                .padding()
            
            Spacer()
                .frame(height: 60)
            
            HStack {
                Text(labels[currentStep])
                    .foregroundStyle(Color.white)
                Spacer()
            }
            .padding(.horizontal)
            
            TextField(placeholders[currentStep], text: $textInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .textInputAutocapitalization(.never)
            
            Spacer()
                .frame(height: 20)
            
            Button(action: {
                if currentStep < labels.count - 1 {
                    currentStep += 1
                    textInput = ""  // Clear the text field for the next input
                }
            }){
                Text("Next")
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
    ProfileView()
}
