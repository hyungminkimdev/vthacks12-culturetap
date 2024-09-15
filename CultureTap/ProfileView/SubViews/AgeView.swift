//
//  AgeView.swift
//  CultureTap
//
//  Created by Henry's Mac on 9/14/24.
//

import SwiftUI

struct AgeView: View {
    @ObservedObject var userProfile: UserProfile
    @State private var selectedAge = "18"
    
    var body: some View {
        let ages: [String] = {
                return (1...120).map { String($0) }
            }()
        VStack {
            HStack {
                Text("Select your Age")
                    .foregroundStyle(Color.white)
                Spacer()
            }
            .padding(.horizontal)
            
            Picker("Age", selection: $selectedAge) {
                ForEach(ages, id: \.self) { age in
                    Text(age)
                        .tag(age)
                        .foregroundStyle(Color.white)
                }
            }
            .frame(maxWidth: .infinity)
            .pickerStyle(.inline)
            .padding()
            .onChange(of: selectedAge) { newValue in
                userProfile.country = newValue
            }
        }
        .background(Color.background)
    }
}

struct AgeView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userProfile: UserProfile(name: "Hyungmin", age: 28, country: "Korea", hobbies: "Reading", mbti: "ESFJ", funFacts: "Likes coding"))
    }
}
