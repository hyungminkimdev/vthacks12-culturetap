import SwiftUI

struct ProfileView: View {
    @State var currentStep: Int = 0
    @ObservedObject var userProfile: UserProfile
    
    // This state will control the navigation
    @State private var navigateToConnectionReady = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                
                Spacer()
                    .frame(height: 180)
                
                Image("Logo")
                    .resizable()
                    .frame(width: 320, height: 100)
                    .padding()
                
                switch currentStep {
                case 0:
                    NameView(userProfile: userProfile)
                case 1:
                    AgeView(userProfile: userProfile)
                case 2:
                    CountryView(userProfile: userProfile)
                case 3:
                    HobbiesView(userProfile: userProfile)
                case 4:
                    MbtiView(userProfile: userProfile)
                case 5:
                    FunFactsView(userProfile: userProfile)
                default:
                    EmptyView()
                }
                
                Spacer()
                
                Button(action: {
                    if currentStep < 5 {
                        currentStep += 1
                    } else {
                        // Navigate to ConnectionReadyView when on the last step
                        navigateToConnectionReady = true
                    }
                    print("Name: \(userProfile.name), Age: \(userProfile.age), City: \(userProfile.country), Hobbies: \(userProfile.hobbies), FunFacts: \(userProfile.funFacts), MBTI: \(userProfile.mbti)")
                }) {
                    Text("Next")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.keyColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                // NavigationLink for transitioning to ConnectionReadyView
                NavigationLink(
                    destination: ConnectionReadyView(),
                    isActive: $navigateToConnectionReady,
                    label: { EmptyView() }
                )
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color.background
                    .ignoresSafeArea()
            }
        }
        .navigationBarItems(leading: Button(action: {
            if currentStep >= 1 {
                currentStep -= 1
            } else {
                presentationMode.wrappedValue.dismiss()
            }
        }) {
            HStack {
                Text("<")
                    .font(.title2)
                    .foregroundStyle(Color.white)
            }
        })
        .navigationBarBackButtonHidden()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userProfile: UserProfile(name: "Hyungmin", age: 28, country: "Korea", hobbies: "Reading", mbti: "ESFJ", funFacts: "Likes coding"))
    }
}
