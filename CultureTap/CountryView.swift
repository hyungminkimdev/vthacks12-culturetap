//
//  CountryView.swift
//  CultureTap
//
//  Created by Henry's Mac on 9/14/24.
//

import SwiftUI

struct CountryView: View {
    @ObservedObject var userprofile: UserProfile
    let countries = ["United States", "Canada", "South Korea", "Germany", "France", "Japan"]
    var body: some View {
        let currentStep: Int = 2
        @State var selectedCountry = "United States"
        
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
                Text("Select your Country")
                    .foregroundStyle(Color.white)
                Spacer()
            }
            .padding(.horizontal)
            
            Picker("Country", selection: $selectedCountry) {
                ForEach(countries, id: \.self) { country in
                    Text(country).tag(country)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            
        }
        .background(Color.background)
    }
}

//#Preview {
//    CountryView()
//}
