//
//  UserProfile.swift
//  CultureTap
//
//  Created by Henry's Mac on 9/15/24.
//

import Foundation
import SwiftUI
import Combine

class UserProfile: ObservableObject, Codable {
    @Published var name: String
    @Published var age: Int
    @Published var country: String
    @Published var hobbies: String
    @Published var mbti: String
    @Published var funFacts: String
    
    enum CodingKeys: String, CodingKey {
        case name, age, country, hobbies, mbti, funFacts
    }
    
    init(name: String, age: Int, country: String, hobbies: String, mbti: String, funFacts: String) {
        self.name = name
        self.age = age
        self.country = country
        self.hobbies = hobbies
        self.mbti = mbti
        self.funFacts = funFacts
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int.self, forKey: .age)
        country = try container.decode(String.self, forKey: .country)
        hobbies = try container.decode(String.self, forKey: .hobbies)
        mbti = try container.decode(String.self, forKey: .mbti)
        funFacts = try container.decode(String.self, forKey: .funFacts)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        try container.encode(country, forKey: .country)
        try container.encode(hobbies, forKey: .hobbies)
        try container.encode(mbti, forKey: .mbti)
        try container.encode(funFacts, forKey: .funFacts)
    }
}

