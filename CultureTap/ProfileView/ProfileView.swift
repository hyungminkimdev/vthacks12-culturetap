//
//  ProfileView.swift
//  CultureTap
//
//  Created by Henry's Mac on 9/14/24.
//

import SwiftUI

struct ProfileView: View {
    @State var currentStep: Int = 0
    @ObservedObject var userprofile: UserProfile
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("Logo")
                .resizable()
                .frame(width: 320, height: 100)
                .padding()
            
            Spacer()
                .frame(height: 60)
            
            
                switch currentStep {
                case 0:
                    NameView(userprofile: userprofile)
                case 1:
                    AgeView(userprofile: userprofile)
                case 2:
                    CountryView(userprofile: userprofile)
                case 3:
                    HobbiesView(userprofile: userprofile)
                case 4:
                    MBTIView(userprofile: userprofile)
                case 5:
                    FunFactsView(userprofile: userprofile)
                default:
                    EmptyView()
                }
            
            
            Spacer()
            
            Button(action: {
                currentStep += 1
                print("Name: \(userprofile.name), Age: \(userprofile.age), City: \(userprofile.country), Hobbies: \(userprofile.hobbies), FunFacts: \(userprofile.funFacts), MBTI: \(userprofile.mbti)")
            }){
                Text("Next")
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
//    ProfileView(userprofile: .constant(UserProfile(name: "Hyungmin", age: 28, city: "Seoul")))
//}
