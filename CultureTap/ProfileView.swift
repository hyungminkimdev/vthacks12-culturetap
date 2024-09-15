//
//  ProfileView.swift
//  CultureTap
//
//  Created by Henry's Mac on 9/14/24.
//

import SwiftUI

struct ProfileView: View {
    @State var currentStep: Int = 0
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("Logo")
                .resizable()
                .frame(width: 320, height: 100)
                .padding()
            
            Spacer()
                .frame(height: 60)
            
            Group {
                switch currentStep {
                case 0:
                    NameView()
                case 1:
                    AgeView()
                case 2:
                    CountryView()
                case 3:
                    HobbiesView()
                case 4:
                    MBTIView()
                case 5:
                    FunFactsView()
                default:
                    EmptyView()
                }
            }
            
            Spacer()
            
            Button(action: {
                currentStep += 1
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

#Preview {
    ProfileView()
}
