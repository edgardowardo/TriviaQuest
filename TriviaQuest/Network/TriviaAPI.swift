import Foundation

protocol TriviaAPIProviding: Sendable {
    func fetch() async throws -> [TriviaItem]
}

@globalActor
actor NetworkActor {
    static let shared = NetworkActor()
}

struct TriviaAPI: Sendable, TriviaAPIProviding {
    let baseURL: URL
    let session: URLSession
    
    init(baseURL: URL = URL(string: "https://opentdb.com/api.php")!, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }
    
    @NetworkActor
    //https://opentdb.com/api.php?amount=15
    func fetch() async throws -> [TriviaItem] {
        let request = URLRequest(url: baseURL.appending(queryItems: [.init(name: "amount", value: "15")]))
        let (data, _) = try await session.data(for: request)
        let response = try JSONDecoder().decode(TriviaAPIResponse.self, from: data)
        return response.results
    }
}
