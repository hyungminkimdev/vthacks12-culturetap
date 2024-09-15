import SwiftUI

struct ProfileView: View {
    @State var currentStep: Int = 0
    @ObservedObject var userprofile: UserProfile
    
    // This state will control the navigation
    @State private var navigateToConnectionReady = false

    var body: some View {
        NavigationView {
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
                    if currentStep < 5 {
                        currentStep += 1
                    } else {
                        // Navigate to ConnectionReadyView when on the last step
                        navigateToConnectionReady = true
                    }
                    print("Name: \(userprofile.name), Age: \(userprofile.age), City: \(userprofile.country), Hobbies: \(userprofile.hobbies), FunFacts: \(userprofile.funFacts), MBTI: \(userprofile.mbti)")
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
    }
}

// Preview
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(userprofile: UserProfile(name: "Hyungmin", age: 28, country: "Korea", hobbies: ["Reading"], mbti: "ESFJ", funFacts: "Likes coding"))
//    }
//}
