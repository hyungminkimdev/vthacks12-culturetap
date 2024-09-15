//
//  MBTIView.swift
//  CultureTap
//
//  Created by Henry's Mac on 9/14/24.
//

import SwiftUI

struct MbtiView: View {
    @ObservedObject var userProfile: UserProfile
    @State private var selectedMbti = "ENTJ - The Commander"
    
    var body: some View {
        let mbtis: [String] = [
            "INTJ - The Architect",
            "INTP - The Thinker",
            "ENTJ - The Commander",
            "ENTP - The Debater",
            "INFJ - The Advocate",
            "INFP - The Mediator",
            "ENFJ - The Protagonist",
            "ENFP - The Campaigner",
            "ISTJ - The Logistician",
            "ISFJ - The Defender",
            "ESTJ - The Executive",
            "ESFJ - The Consul",
            "ISTP - The Virtuoso",
            "ISFP - The Adventurer",
            "ESTP - The Entrepreneur",
            "ESFP - The Entertainer"
        ]
        
        VStack {
            HStack {
                Text("MBTI Type")
                    .foregroundStyle(Color.white)
                Spacer()
            }
            .padding(.horizontal)
            
            Picker("MBTI", selection: $selectedMbti) {
                ForEach(mbtis, id: \.self) { mbti in
                    Text(mbti)
                        .tag(mbti)
                        .foregroundStyle(Color.white)
                }
            }
            .frame(maxWidth: .infinity)
            .pickerStyle(.inline)
            .padding()
            .onChange(of: selectedMbti) { newValue in
                userProfile.mbti = newValue
            }
        }
        .background(Color.background)
    }
}

struct MbtiView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userProfile: UserProfile(name: "Hyungmin", age: 28, country: "Korea", hobbies: "Reading", mbti: "ESFJ", funFacts: "Likes coding"))
    }
}
