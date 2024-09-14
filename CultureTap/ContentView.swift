//
//  ContentView.swift
//  CultureTap
//
//  Created by Henry's Mac on 9/14/24.
//

import SwiftUI

struct ContentView: View {
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



//struct ContentView: View {
//    @StateObject var dataMultipeerManager = DataMultipeerManager()
//    var body: some View {
//        VStack {
//            Button("Start Hosting") {
//                // Initiate hosting (already started in init method)
//            }
//            .padding()
//            
//            Button("Join Session") {
//                // Initiate browsing (already started in init method)
//            }
//            .padding()
//            
//            Button("Confirm") {
//                dataMultipeerManager.sendMessage("hello")
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                    dataMultipeerManager.sendMessage("world")
//                }
//            }
//            .padding()
//            
//            List(dataMultipeerManager.connectedPeers, id: \.self) { peer in
//                Text(peer.displayName)
//            }
//        }
//        .padding()
//    }
//}

#Preview {
    ContentView()
}
