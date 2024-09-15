//
//  AgeView.swift
//  CultureTap
//
//  Created by Henry's Mac on 9/14/24.
//

import SwiftUI

struct AgeView: View {
    var body: some View {
        let currentStep: Int = 1
        @State var textInput: String = ""
        
        let labels = ["Name", "Age", "Country", "Hobbies", "MBTI", "Fun Fact"]
        let placeholders = [
            "Enter your name",
            "Enter your age",
            "Enter your country",
            "Enter your hobbies",
            "Enter your MBTI",
            "Enter a fun fact about you"
        ]
        VStack {
            HStack {
                Text("Age")
                    .foregroundStyle(Color.white)
                Spacer()
            }
            .padding(.horizontal)
            
            TextField("Enter your age", text: $textInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .textInputAutocapitalization(.never)
        }
        .background(Color.background)
    }
}

#Preview {
    AgeView()
}
