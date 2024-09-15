//
//  FunFactsView.swift
//  CultureTap
//
//  Created by Henry's Mac on 9/14/24.
//

import SwiftUI

struct FunFactsView: View {
    @ObservedObject var userProfile: UserProfile
    @State private var textInput: String = ""

    var body: some View {
        VStack {
            HStack {
                Text("Fun Facts")
                    .foregroundStyle(Color.white)
                Spacer()
            }
            .padding(.horizontal)
            
            TextField("Enter your fun facts", text: $textInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .textInputAutocapitalization(.never)
                .onChange(of: textInput) { newValue in
                    userProfile.funFacts = newValue
                }
        }
        .background(Color.background)
    }
}


struct FunFacts_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userProfile: UserProfile(name: "Hyungmin", age: 28, country: "Korea", hobbies: "Reading", mbti: "ESFJ", funFacts: "Likes coding"))
    }
}
