//
//  FunFactsView.swift
//  CultureTap
//
//  Created by Henry's Mac on 9/14/24.
//

import SwiftUI

struct FunFactsView: View {
    @ObservedObject var userprofile: UserProfile
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
                    userprofile.funFacts = newValue
                }
        }
        .background(Color.background)
    }
}


//#Preview {
//    FunFactsView()
//}
