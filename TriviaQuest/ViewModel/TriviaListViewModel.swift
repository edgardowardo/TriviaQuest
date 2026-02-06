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
        guard difficultyFilter != nil || categoryFilter != nil || searchText != nil else {
            return _trivias
        }
        return _trivias.filter {
            let d = (difficultyFilter == nil ? false : difficultyFilter == $0.difficulty )
            let c = (categoryFilter == nil ? false : categoryFilter == $0.category )
            let q = $0.question.localizedCaseInsensitiveContains(searchText ?? "")
            
            return d || c || q
        }
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
