//
//  FunFactsView.swift
//  CultureTap
//
//  Created by Henry's Mac on 9/14/24.
//

import SwiftUI

struct FunFactsView: View {
    @ObservedObject var userprofile: UserProfile
    
    var body: some View {
        Text("userprofile")
            .onAppear {
                print("\(userprofile)")
            }
    }
}

//#Preview {
//    FunFactsView()
//}
