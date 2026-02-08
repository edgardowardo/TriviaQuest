import SwiftUI

struct TriviaListView: View {

    @State var vm: TriviaListViewModel
    
    var body: some View {
        
        let searchTextBinding = Binding<String>(
            get: { vm.searchText ?? "" },
            set: { v in
                withAnimation {
                    vm.searchText = v.isEmpty ? nil : v
                }
            }
        )

        NavigationStack {
            List(vm.trivias) { t in
                NavigationLink {
                    TriviaItemView(vm: t)
                } label: {
                    HStack {
                        Image(systemName: t.statusImageName)
                            .foregroundStyle(.secondary)

                        VStack(alignment: .leading) {
                            Text(t.difficulty.rawValue.capitalized + ", " + t.category.rawValue)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            
                            Text(t.question)
                        }
                    }
                }
                .listRowBackground(t.rowBackgroundColor)
            }
 
            .navigationTitle(vm.navigationTitle)

            .refreshable {
                await vm.fetch()
            }
            
            .searchable(text: searchTextBinding)
            
            .toolbar {
                ToolbarItem {
                    Menu {
                        Picker("Difficulty", selection: $vm.difficultyFilter) {
                            Text("All difficulty")
                                .tag(Optional<TriviaDifficulty>.none)
                            ForEach(TriviaDifficulty.allCases, id: \.self) { d in
                                Label(d.rawValue.capitalized, systemImage: d.systemImageName)
                                    .tag(Optional(d))
                            }
                            
                        }
                        
                        Picker("Category", selection: $vm.categoryFilter) {
                            Text("All category")
                                .tag(Optional<TriviaCategory>.none)
                            ForEach(TriviaCategory.allCases, id: \.self) { c in
                                Text(c.rawValue)
                                    .tag(Optional(c))
                            }
                        }
                    } label: {
                        Label("Filters", systemImage: "line.3.horizontal.decrease")
                    }
                }
            }
                    
        }

        .task {
            await vm.fetch()
        }

        .alert("Refresh Failed", isPresented: .constant(vm.refreshError != nil), presenting: vm.refreshError) { error in
            Button("OK") { vm.refreshError = nil }
        } message: { error in
            Text(error.localizedDescription)
        }

    }
}

extension TriviaItemViewModel {
    var rowBackgroundColor: Color {
        isVisited ? .secondary.opacity(0.1) : .clear
    }
}

extension TriviaDifficulty {
    var color: Color {
        switch self {
        case .easy: return .green
        case .medium: return .yellow
        case .hard: return .red
        }
    }
    
    var systemImageName: String {
        switch self {
        case .easy: return "gauge.with.dots.needle.0percent"
        case .medium: return "gauge.with.dots.needle.50percent"
        case .hard: return "gauge.with.dots.needle.100percent"
        }
    }
}

#Preview {
    TriviaListView(vm: .init(api: TriviaAPI()))
}
