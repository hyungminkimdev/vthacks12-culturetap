//
//  MBTIView.swift
//  CultureTap
//
//  Created by Henry's Mac on 9/14/24.
//

import SwiftUI

struct MBTIView: View {
    @ObservedObject var userprofile: UserProfile
    @State private var textInput: String = ""

    var body: some View {
        VStack {
            HStack {
                Text("MBTI Type")
                    .foregroundStyle(Color.white)
                Spacer()
            }
            .padding(.horizontal)
            
            TextField("Enter your MBTI type", text: $textInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .textInputAutocapitalization(.never)
                .onChange(of: textInput) { newValue in
                    userprofile.mbti = newValue
                }
        }
        .background(Color.background)
    }
}

//#Preview {
//    MBTIView()
//}
