//
//  QuizResultView.swift
//  CultureTap
//
//  Created by Harditya Sarvaiya on 9/15/24.
//

import SwiftUI

struct QuizResultView: View {
    @ObservedObject var userprofile: UserProfile
    @State var textInput: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading) {
                Text("Quiz Results")
                    .font(.largeTitle)
                Text("Yaay! You got 3 out of 4 correct. Here is your badge.")
                    .font(.title3)
            }
            .foregroundStyle(Color.white)
            
            Spacer()
            
            Image("Badge_SouthKorea")
                .resizable()
                .frame(width: 240, height: 240)
            
            Spacer()
            
            Text("You got a badge of South Korea. Connect to more people at the event to win more badges.")
                .foregroundStyle(Color.white)
                .font(.title3)
                .padding()
            
            Button(action: {
                dismiss()
            }) {
                Text("Back to home")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.keyColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.background
                .ignoresSafeArea()
        }
    }
}
//#Preview {
//    let mockUserProfile = UserProfile(name: "John Doe", age: 30, country: "USA", hobbies: "Reading, Hiking", mbti: "INTJ", funFacts: "Loves traveling")
//    QuizResultView(userprofile: mockUserProfile)
//}

struct QuizResultView_Previews: PreviewProvider {
    static var previews: some View {
        let mockUserProfile = UserProfile(name: "John Doe", age: 30, country: "USA", hobbies: "Reading, Hiking", mbti: "INTJ", funFacts: "Loves traveling")
        QuizResultView(userprofile: mockUserProfile)
            .previewLayout(.sizeThatFits)
    }
}
