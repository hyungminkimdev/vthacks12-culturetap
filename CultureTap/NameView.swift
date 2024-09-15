//
//  NameView.swift
//  CultureTap
//
//  Created by Henry's Mac on 9/14/24.
//

import SwiftUI

struct NameView: View {
    var body: some View {
        @State var currentStep: Int = 0
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
                Text("Name")
                    .foregroundStyle(Color.white)
                Spacer()
            }
            .padding(.horizontal)
            
            TextField("Enter your name", text: $textInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .textInputAutocapitalization(.never)
        }
        .background(Color.background)
    }
}

#Preview {
    NameView()
}
