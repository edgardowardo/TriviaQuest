import Testing
import Foundation
@testable import TriviaQuest

@Suite("TriviaAPI JSON parsing tests", .serialized)
@MainActor
struct TriviaAPITests {
        
    @Test("fetch decodes data into TriviaItem objects correctly")
    func testFetchParsesCorrectly() async throws {
        let data = StubData.sampleJSON.data(using: .utf8)!
        let session = getMockSession(from: data)
        let sut = TriviaAPI(session: session)
        let results = try await sut.fetch()
        
        #expect(results.contains(where: { $0.category == .film }))
        #expect(results.first?.category == .scienceAndNature)
        #expect(results.last?.category == .videoGames)
        #expect(results.count == 15)
    }
    
    @Test("fetch throws on invalid data")
    func testFetchThrowsOnInvalidData() async {
        let data = Data("invalid data".utf8)
        let session = getMockSession(from: data)
        let sut = TriviaAPI(session: session)
        do {
            _ = try await sut.fetch()
            #expect(Bool(false), "Expected error but got none")
        } catch {
            #expect(true)
        }
    }
    
    @Test("object encode TriviaItem objects correctly")
    func testEncodeTriviaItem() async throws {
        // decode from mock session
        let data = StubData.sampleJSON.data(using: .utf8)!
        let session = getMockSession(from: data)
        let sut = TriviaAPI(session: session)
        let result = try await sut.fetch()
        let triviaContainer: TriviaAPIResponse = .init(responseCode: 0, results: result, result: nil)
        
        // encode
        let jsonData = try JSONEncoder().encode(triviaContainer)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        #expect(jsonString.contains("Science &amp; Nature"))
        
        // decode back again from encoded
        let data2 = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let response = try decoder.decode(TriviaAPIResponse.self, from: data2)
        #expect(await response.results?.first?.category == .scienceAndNature)
        #expect(await response.results?.last?.category == .videoGames)
        #expect(response.results?.count == 15)
    }
}

