import Foundation

enum TriviaCategory: String, Sendable, CaseIterable {
    case generalKnowledge = "General Knowledge"
    case books = "Entertainment: Books"
    case film = "Entertainment: Film"
    case music = "Entertainment: Music"
    case musicalsAndTheatres = "Entertainment: Musicals & Theatres"
    case tv = "Entertainment: Television"
    case videoGames = "Entertainment: Video Games"
    case boardGames = "Entertainment: Board Games"
    case scienceAndNature = "Science & Nature"
    case computers = "Science: Computers"
    case mathematics = "Science: Mathematics"
    case mythology = "Mythology"
    case sports = "Sports"
    case geography = "Geography"
    case history = "History"
    case politics = "Politics"
    case art = "Art"
    case celebrities = "Celebrities"
    case animals = "Animals"
    case vehicles = "Vehicles"
    case comics = "Entertainment: Comics"
    case gadgets = "Science: Gadgets"
    case animeAndManga = "Entertainment: Japanese Anime & Manga"
    case cartoonAndAnimations = "Entertainment: Cartoon & Animations"
}

extension TriviaCategory: Codable {
    nonisolated init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let raw = try container.decode(String.self)

        guard let value = TriviaCategory(rawValue: raw.attributedHTML) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Unknown TriviaCategory: \(raw)"
            )
        }
        self = value
    }

    nonisolated func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.rawValue.replacingOccurrences(of: "&", with: "&amp;"))
    }
}

