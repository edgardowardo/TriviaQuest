import Observation
import Foundation

@Observable
class TriviaListViewModel {
    
    var isLoading: Bool
    var refreshError: Error?
    var searchText: String?
    var difficultyFilter: TriviaDifficulty?
    var categoryFilter: TriviaCategory?
    
    let navigationTitle = "Trivia Quest"
    let api: TriviaAPIProviding
    
    init(api: TriviaAPIProviding) {
        self.api = api
        self.isLoading = false
        self.refreshError = nil
        self._trivias = []
    }
    
    var trivias: [TriviaItemViewModel] {
        []
    }
    
    private var _trivias: [TriviaItemViewModel]
    
    func fetch() async {
        do {
            isLoading = true
            let trivias = try await api.fetch()
            _trivias = trivias.map { .init(trivia: $0)  }
            isLoading = false
            refreshError = nil
        } catch {
            self.refreshError = error
            _trivias = []
            isLoading = false
        }
    }
        
}
