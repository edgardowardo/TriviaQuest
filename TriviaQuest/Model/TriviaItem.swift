import Foundation
import UIKit

enum TriviaType: String, Codable, Sendable {
    case multiple, boolean
}

enum TriviaDifficulty: String, Codable, Sendable, CaseIterable {
    case easy, medium, hard
}

struct TriviaItem: Hashable, Sendable {
    let type: TriviaType
    let difficulty: TriviaDifficulty
    let category: TriviaCategory
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
}

extension TriviaItem: Codable {

    enum CodingKeys: String, CodingKey {
        case type, difficulty, category, question, correctAnswer = "correct_answer", incorrectAnswers = "incorrect_answers"
    }
    
    nonisolated init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        type = try c.decode(TriviaType.self, forKey: .type)
        difficulty = try c.decode(TriviaDifficulty.self, forKey: .difficulty)
        category = try c.decode(TriviaCategory.self, forKey: .category)
        question = (try c.decode(String.self, forKey: .question)).attributedHTML
        correctAnswer = (try c.decode(String.self, forKey: .correctAnswer)).attributedHTML
        incorrectAnswers = (try c.decode([String].self, forKey: .incorrectAnswers)).map(\.attributedHTML)
    }
    
    nonisolated func encode(to encoder: Encoder) throws {
        var e = encoder.container(keyedBy: CodingKeys.self)
        try e.encode(type, forKey: .type)
        try e.encode(difficulty, forKey: .difficulty)
        try e.encode(category, forKey: .category)
        try e.encode(question, forKey: .question)
        try e.encode(correctAnswer, forKey: .correctAnswer)
        try e.encode(incorrectAnswers, forKey: .incorrectAnswers)
    }
}

extension String {
    nonisolated var attributedHTML: String {
        guard let data = self.data(using: .utf8) else { return self }
        if let ns = try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
        ) {
            return ns.string
        }
        return self
    }
}
