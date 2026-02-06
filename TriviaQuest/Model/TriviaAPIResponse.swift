import Foundation

struct TriviaAPIResponse: Sendable {
    let responseCode: Int
    let results: [TriviaItem]?
    let result: [TriviaItem]? // TODO: what is code 5?
}

extension TriviaAPIResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results
        case result
    }
    
    nonisolated init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.responseCode = try container.decode(Int.self, forKey: .responseCode)
        self.results = try container.decodeIfPresent([TriviaItem].self, forKey: .results)
        self.result = try container.decodeIfPresent([TriviaItem].self, forKey: .result)
    }
    
    nonisolated func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.responseCode, forKey: .responseCode)
        try container.encode(self.results, forKey: .results)
        try container.encode(self.result, forKey: .result)
    }
}
