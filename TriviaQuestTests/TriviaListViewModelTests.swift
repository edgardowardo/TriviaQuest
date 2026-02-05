import Testing
import Foundation
@testable import TriviaQuest

@Suite("TriviaList ViewModel tests", .serialized)
@MainActor
struct TriviaListViewModelTests {
    
    @Test("view model correctly maps trivia items to view models")
    func testViewModelMapping() async {
        let data = StubData.sampleJSON.data(using: .utf8)!
        let session = getMockSession(from: data)
        let api = await TriviaAPI(session: session)
        let sut = TriviaListViewModel(api: api)
        
        await sut.fetch()

        #expect(sut.isLoading == false)
        #expect(sut.refreshError == nil)
        #expect(sut.trivias.contains(where: { $0.category == .film }))
        #expect(sut.trivias.first?.category == .scienceAndNature)
        #expect(sut.trivias.last?.category == .videoGames)
        #expect(sut.trivias.count == 15)
    }
    
    @Test("view model emits refresh error")
    func testRefreshErrorEmitted() async {
        let data = Data("invalid data".utf8)
        let session = getMockSession(from: data)
        let api = await TriviaAPI(session: session)
        let sut = TriviaListViewModel(api: api)
        
        await sut.fetch()
        
        #expect(sut.isLoading == false)
        #expect(sut.refreshError != nil)
    }
}
