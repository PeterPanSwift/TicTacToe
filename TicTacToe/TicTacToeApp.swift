//
//  TicTacToeApp.swift
//  TicTacToe
//
//  Created by SHIH-YING PAN on 2024/11/13.
//

import SwiftUI

@main
struct TicTacToeApp: App {
    @State private var gameState = GameState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(gameState)
        }
    }
}
