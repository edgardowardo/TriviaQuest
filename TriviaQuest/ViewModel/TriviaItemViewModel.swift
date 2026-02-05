import Observation

@Observable
class TriviaItemViewModel: Identifiable {
    
    var isVisited: Bool
    
    private let trivia: TriviaItem
    
    init(trivia: TriviaItem) {
        self.isVisited = false
        self.trivia = trivia
    }
    
    var id: String { trivia.question }
    var type: TriviaType { trivia.type }
    var difficulty: TriviaDifficulty { trivia.difficulty }
    var category: TriviaCategory { trivia.category }
    var question: String { trivia.question }
    var answers: [String] { (trivia.incorrectAnswers + [trivia.correctAnswer]).shuffled() }
    
    func onAppear() {
        isVisited = true
    }
    
}
