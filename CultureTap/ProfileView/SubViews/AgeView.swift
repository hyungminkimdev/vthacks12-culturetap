//
//  AgeView.swift
//  CultureTap
//
//  Created by Henry's Mac on 9/14/24.
//

import SwiftUI

struct AgeView: View {
    @ObservedObject var userprofile: UserProfile
    @State var textInput: String = "0"

    var body: some View {
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
                .onChange(of: textInput) { newValue in
                                    if let age = Int(newValue) {
                                        userprofile.age = age
                                    }
                                }
        }
        .background(Color.background)
    }
}

//#Preview {
//    AgeView()
//}
