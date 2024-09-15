import SwiftUI

struct ConnectionReadyView: View {
    @StateObject var connectDevicesSession = ConnectDevicesSession()
    
    var body: some View {
        Group {
            if connectDevicesSession.userProfile == nil {
                WaitingView()
            } else {
                ProfileReceivedView()
            }
        }    }
}

struct WaitingView: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                ZStack {
                    Circle()
                        .fill(Color.mint)
                        .frame(width: 80, height: 80)
                    
                    Image(systemName: "checkmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                }
                
                Text("Ready to go !")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Text("We have received your profile. Tap\nwith another phone to connect\nwith them")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .font(.body)
            }
        }
    }
}

struct ProfileReceivedView: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Profile Received!")
                    .font(.title)
                    .foregroundColor(.white)
                
                Text("You're now connected.")
                    .foregroundColor(.gray)
                
                // Add more details or navigation options here
            }
        }
    }
}

#Preview {
    ConnectionReadyView()
}
