import Observation
import Foundation

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
    
    var navigationTitle: String {
        trivia.difficulty.rawValue.capitalized + " Question"
    }
    
    var typeSystemImageName: String {
        type.systemImageName
    }
}

extension TriviaType {
    var systemImageName: String {
        switch self {
        case .boolean: return "checkmark.circle"
        case .multiple: return "list.number"
        }
    }
}
