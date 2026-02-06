import Foundation

struct TriviaAPIResponse: Sendable {
    let responseCode: Int
    let results: [TriviaItem]
}

extension TriviaAPIResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results
    }
    
    nonisolated init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.responseCode = try container.decode(Int.self, forKey: .responseCode)
        self.results = try container.decode([TriviaItem].self, forKey: .results)
    }
    
    nonisolated func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.responseCode, forKey: .responseCode)
        try container.encode(self.results, forKey: .results)
    }
}
