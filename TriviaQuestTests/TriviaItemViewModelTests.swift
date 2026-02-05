import Testing
import Foundation
@testable import TriviaQuest

@Suite("TriviaItem ViewModel tests")
@MainActor
struct TriviaItemViewModelTests {
    
    @Test("view model extracts multiple choice question and answers correctly")
    func testMultipleChoiceExtraction() {
        let sut = TriviaItemViewModel(trivia: mockTriviaItemMultipleChoice)
        #expect(sut.question == "After which Danish city is the 72th element on the periodic table named?")
        #expect(sut.answers.count == 4)
        #expect(sut.answers.contains("Copenhagen"))
    }
    
    @Test("view model extracts true or false question correctly")
    func testTrueFalseExtraction() {
        let sut = TriviaItemViewModel(trivia: mockTriviaItemTrueFalse)
        #expect(sut.question == "Was the Titanic sunk in the North Atlantic Ocean?")
        #expect(sut.answers.count == 2)
        #expect(sut.answers.contains("True"))
    }
    
    @Test("view model is visited on appear")
    func testVisitedOnAppear() {
        let sut = TriviaItemViewModel(trivia: mockTriviaItemMultipleChoice)
        #expect(!sut.isVisited)
        sut.onAppear()
        #expect(sut.isVisited)
    }
}

private var mockTriviaItemMultipleChoice: TriviaItem {
    .init(type: .multiple,
          difficulty: .medium,
          category: .scienceAndNature,
          question: "After which Danish city is the 72th element on the periodic table named?",
          correctAnswer: "Copenhagen",
          incorrectAnswers: [
            "Odense",
            "Herning",
            "Skagen"
          ])
}

private var mockTriviaItemTrueFalse: TriviaItem {
    .init(type: .boolean,
          difficulty: .easy,
          category: .history,
          question: "Was the Titanic sunk in the North Atlantic Ocean?",
          correctAnswer: "True",
          incorrectAnswers: [
            "False"
          ])
}

