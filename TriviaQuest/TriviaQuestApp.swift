//
//  TriviaQuestApp.swift
//  TriviaQuest
//
//  Created by EDGARDO AGNO on 05/02/2026.
//

import SwiftUI

@main
struct TriviaQuestApp: App {
    var body: some Scene {
        WindowGroup {
            TriviaListView(vm: .init(api: TriviaAPI()))
        }
    }
}
