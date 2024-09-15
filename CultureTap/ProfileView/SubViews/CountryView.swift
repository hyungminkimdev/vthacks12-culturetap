//
//  CountryView.swift
//  CultureTap
//
//  Created by Henry's Mac on 9/14/24.
//

import SwiftUI


struct CountryView: View {
    @ObservedObject var userProfile: UserProfile
    @State private var selectedCountry = "United States"
    
    let countries = [
        "United States 🇺🇸", "Canada 🇨🇦", "South Korea 🇰🇷", "Germany 🇩🇪", "France 🇫🇷", "Japan 🇯🇵",
        "Australia 🇦🇺", "Brazil 🇧🇷", "China 🇨🇳", "India 🇮🇳", "Italy 🇮🇹", "Mexico 🇲🇽", "Netherlands 🇳🇱",
        "New Zealand 🇳🇿", "Russia 🇷🇺", "South Africa 🇿🇦", "Spain 🇪🇸", "Sweden 🇸🇪", "Switzerland 🇨🇭",
        "Turkey 🇹🇷", "United Kingdom 🇬🇧"
        // Add more countries as needed
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("Select your Country")
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.horizontal)
            
            Picker("Country", selection: $selectedCountry) {
                ForEach(countries, id: \.self) { country in
                    Text(country)
                        .tag(country)
                        .foregroundStyle(Color.white)
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color.black)
            .pickerStyle(MenuPickerStyle())
            .padding()
            .onChange(of: selectedCountry) { newValue in
                userProfile.country = newValue
            }
            
        }
        
    }
}

//#Preview {
//    CountryView()
//}


//#Preview {
//    let sampleProfile = UserProfile(name: "Hyungmin", age: 28, country: "Korea", hobbies: ["Reading"], mbti: "ESFJ", funFacts: "Likes coding")
//    HobbiesView(userprofile: sampleProfile)
//}
