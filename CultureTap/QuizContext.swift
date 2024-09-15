import SwiftUI

struct QuizContext: View {
    @State private var navigateToQuiz = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    SpiderWebView()
                        .frame(width: 120, height: 120)
                    
                    Text("Your personalities are quite complimentary")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Say hi to Hyunmin in their language")
                            .foregroundColor(.white)
                            .font(.subheadline)
                        
                        Text("Annyeong, Hyunmin")
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(8)
                            .foregroundColor(.white)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Some info about Hyunmin")
                            .foregroundColor(.white)
                            .font(.subheadline)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Hyunmin Kim")
                            Text("Age: 28")
                            Text("Nationality: South Korea")
                            Text("Hobbies: Surfing, basketball")
                            Text("Fun fact: His favourite player is dirk nowitzki. His age in korean is 30")
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: QuizView(), isActive: $navigateToQuiz) {
                        Button(action: {
                            navigateToQuiz = true
                        }) {
                            Text("Take a quiz on them")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.mint)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }
}

struct SpiderWebView: View {
    var body: some View {
        ZStack {
            SpiderWebShape()
                .stroke(Color.white, lineWidth: 1.5)
            SpiderWebShape(spikePercentages: [0.8, 0.6, 0.9, 0.7, 0.5, 0.8, 0.6, 0.7])
                .fill(Color.mint.opacity(0.5))
        }
    }
}

struct SpiderWebShape: Shape {
    var spikePercentages: [CGFloat] = [1, 1, 1, 1, 1, 1, 1, 1]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let sides = 8
        
        // Draw the spikes
        for i in 0..<sides {
            let angle = CGFloat(i) * (2 * .pi / CGFloat(sides)) - .pi / 2
            let spikeLength = radius * spikePercentages[i]
            let x = center.x + cos(angle) * spikeLength
            let y = center.y + sin(angle) * spikeLength
            
            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        path.closeSubpath()
        
        // Draw the internal web lines
        for i in 1...3 {
            let webRadius = radius * CGFloat(i) / 4
            var webPath = Path()
            for j in 0..<sides {
                let angle = CGFloat(j) * (2 * .pi / CGFloat(sides)) - .pi / 2
                let x = center.x + cos(angle) * webRadius
                let y = center.y + sin(angle) * webRadius
                
                if j == 0 {
                    webPath.move(to: CGPoint(x: x, y: y))
                } else {
                    webPath.addLine(to: CGPoint(x: x, y: y))
                }
            }
            webPath.closeSubpath()
            path.addPath(webPath)
        }
        
        // Draw the radial lines
        for i in 0..<sides {
            let angle = CGFloat(i) * (2 * .pi / CGFloat(sides)) - .pi / 2
            let x = center.x + cos(angle) * radius
            let y = center.y + sin(angle) * radius
            path.move(to: center)
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        return path
    }
}



#Preview {
    QuizContext()
}
