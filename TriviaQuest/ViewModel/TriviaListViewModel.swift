import Observation

@Observable
class TriviaListViewModel {
    
    var trivias: [TriviaItemViewModel]
    var isLoading: Bool
    var refreshError: Error?
    
    let navigationTitle = "Trivia Quest"
    let api: TriviaAPIProviding
    
    init(api: TriviaAPIProviding) {
        self.api = api
        self.trivias = []
        self.isLoading = false
        self.refreshError = nil
    }
    
    func fetch() async {
        do {
            isLoading = true
            let trivias = try await api.fetch()
            self.trivias = trivias.map { .init(trivia: $0)  }
            isLoading = false
            refreshError = nil
        } catch {
            self.refreshError = error
            isLoading = false
        }
    }
    
}
