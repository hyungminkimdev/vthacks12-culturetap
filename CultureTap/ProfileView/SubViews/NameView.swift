//
//  NameView.swift
//  CultureTap
//
//  Created by Henry's Mac on 9/14/24.
//

import SwiftUI

struct NameView: View {
    @ObservedObject var userProfile: UserProfile
    @State var textInput: String = ""
    
    var body: some View {
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
                .onChange(of: textInput) { newValue in
                                    userProfile.name = newValue
                                }
        }
        
        .background(Color.background)
    }
}

//#Preview {
//    NameView()
//}
