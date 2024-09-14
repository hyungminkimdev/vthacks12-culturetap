//
//  ConfirmView.swift
//  CultureTap
//
//  Created by Henry's Mac on 9/14/24.
//

import SwiftUI

struct ConfirmView: View {
    @StateObject var colorSession = ColorMultipeerSession()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Connected Devices:")
            Text(String(describing: colorSession.connectedPeers.map(\.displayName)))
            
            Divider()
            
            HStack {
                ForEach(NamedColor.allCases, id: \.self) { color in
                    Button(color.rawValue) {
                        colorSession.send(color: color)
                    }
                    .padding()
                }
            }
            Spacer()
        }
        .padding()
        .background((colorSession.currentColor.map(\.color) ?? .clear).ignoresSafeArea())
    }
}

extension NamedColor {
    var color: Color {
        switch self {
        case .red:
            return .red
        case .green:
            return .green
        case .yellow:
            return .yellow
        }
    }
}

#Preview {
    ConfirmView()
}
