//
//  ColorExtension.swift
//  CultureTap
//
//  Created by Henry's Mac on 9/14/24.
//

import Foundation
import SwiftUI

extension ShapeStyle where Self == Color {
    
    // MARK: - Color init
    
    init(hex: UInt, alpha: Double = 1.0) {
        let red = Double((hex >> 16) & 0xff) / 255.0
        let green = Double((hex >> 8) & 0xff) / 255.0
        let blue = Double(hex & 0xff) / 255.0
        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
    
    static var background: Self { Self(hex: 0x25242B) }
    static var primary: Self { Self(hex: 0xB1EFCD) }

}
