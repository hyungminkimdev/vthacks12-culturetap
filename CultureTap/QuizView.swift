import SwiftUI

struct QuizData: Codable {
    let quiz: Quiz
}

struct Quiz: Codable {
    let questions: [Question]
    let title: String
}

struct Question: Codable, Identifiable {
    let id = UUID()
    let correct_answer: String
    let options: [String]
    let question: String
}

struct QuizView: View {
    @State private var navigateToQuiz = false
    @State private var quizData: QuizData
    @State private var selectedAnswers: [Int: String] = [:]
    @State private var showResult = false
    @State private var score = 0
    
    init() {
        // Initialize with your JSON data
        let jsonString = """
        {
            "quiz": {
                "questions": [
                    {
                        "correct_answer": "Diwali",
                        "options": [
                            "Christmas",
                            "Diwali",
                            "Thanksgiving",
                            "Halloween"
                        ],
                        "question": "What is Kshitij's favorite festival to celebrate?"
                    },
                    {
                        "correct_answer": "Sushi",
                        "options": [
                            "Sushi",
                            "Pizza",
                            "Biryani",
                            "Tacos"
                        ],
                        "question": "If Kshitij is talking about food, what dish is he most likely to mention as a favorite?"
                    },
                    {
                        "correct_answer": "Mumbai",
                        "options": [
                            "Mumbai",
                            "Tokyo",
                            "New York"
                        ],
                        "question": "Kshitij is probably planning to visit which city for a holiday soon?"
                    },
                    {
                        "correct_answer": "No",
                        "options": [
                            "English and Spanish",
                            "English and Hindi",
                            "French and Hindi",
                            "Hindi and German"
                        ],
                        "question": "If you were to text Kshitij, which languages might he reply in?"
                    }
                ],
                "title": "Personalized Quiz for Unknown User"
            }
        }
        """
        let jsonData = Data(jsonString.utf8)
        self._quizData = State(initialValue: try! JSONDecoder().decode(QuizData.self, from: jsonData))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text(quizData.quiz.title)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                
                ForEach(Array(quizData.quiz.questions.enumerated()), id: \.element.id) { index, question in
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Q\(index + 1)) \(question.question)")
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        ForEach(question.options, id: \.self) { option in
                            Button(action: {
                                selectedAnswers[index] = option
                            }) {
                                Text(option)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(selectedAnswers[index] == option ? Color.mint : Color.gray)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.bottom)
                }
                
                NavigationLink(destination: QuizView()) {
                    Button(action: {
                        navigateToQuiz = true
                    }) {
                        Text("Submit")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.mint)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                
//                Button("Submit") {
//                    calculateScore()
//                    showResult = true
//                }
//                .disabled(selectedAnswers.count < quizData.quiz.questions.count)
//                .padding()
//                .background(selectedAnswers.count == quizData.quiz.questions.count ? Color.mint : Color.gray)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//                .frame(maxWidth: .infinity)
                
//                if showResult {
//                    Text("Quiz Completed!")
//                        .font(.title)
//                        .foregroundColor(.white)
//                    
//                    Text("Your score: \(score)/\(quizData.quiz.questions.count)")
//                        .foregroundColor(.white)
//                        .padding()
//                }
            }
            .padding()
        }
        .background {
            Color.background
                .ignoresSafeArea()
    }
}
    
    private func calculateScore() {
        score = 0
        for (index, question) in quizData.quiz.questions.enumerated() {
            if selectedAnswers[index] == question.correct_answer {
                score += 1
            }
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
