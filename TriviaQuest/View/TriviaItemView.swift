import SwiftUI

struct TriviaItemView: View {
    
    @State var vm: TriviaItemViewModel
    
    var body: some View {

        List {

            Section {
                HStack(alignment: .center) {
                    Image(systemName: vm.typeSystemImageName)

                    Text(vm.question)
                }
            } header: {
                Text(vm.category.rawValue)
            }

            Section {
                ForEach(vm.answers, id: \.self) { a in
                    Text(a)
                }
            } header: {
                Text("Answers")
            }
        }
        
        .navigationTitle(vm.navigationTitle)
        
        .onAppear {
            vm.isVisited = true
        }
    }
}

#Preview {
    NavigationStack {
        TriviaItemView(vm: .init(trivia: .init(type: .boolean, difficulty: .easy, category: .animals, question: "Question", correctAnswer: "Delta", incorrectAnswers: ["Alpha", "Beta", "Charlie", "Echo"])))
    }
}
