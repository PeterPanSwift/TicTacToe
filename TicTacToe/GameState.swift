//
//  GameState.swift
//  TicTacToe
//
//  Created by SHIH-YING PAN on 2024/11/13.
//

import SwiftUI

@Observable
class GameState {
    enum Player: String {
        case x = "X"
        case o = "O"
        
        var next: Player {
            self == .x ? .o : .x
        }
        
        var color: Color {
            self == .x ? .blue : .pink
        }
    }
    
    struct Move: Identifiable {
        let id = UUID()
        let player: Player
        let position: Int
        let timestamp: Date
    }
    
    var board = Array(repeating: "", count: 9)
    var currentPlayer = Player.x
    var winner: Player?
    var isDraw = false
    var gameStartTime: Date?
    var gameEndTime: Date?
    var isGameOver: Bool {
        winner != nil || isDraw
    }
    var elapsedTime: TimeInterval {
        guard let startTime = gameStartTime else { return 0 }
        return Date().timeIntervalSince(startTime)
    }
    
    func makeMove(at position: Int) {
        guard position >= 0 && position < 9 && board[position].isEmpty && !isGameOver else {
            return
        }
        
        if gameStartTime == nil {
            gameStartTime = Date()
        }
        
        board[position] = currentPlayer.rawValue
      
        if checkWinner() {
            winner = currentPlayer
            gameEndTime = Date()
        } else if board.allSatisfy({ !$0.isEmpty }) {
            isDraw = true
            gameEndTime = Date()
        } else {
            currentPlayer = currentPlayer.next
        }
    }
    
    func checkWinner() -> Bool {
        let winPatterns = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8],  // Rows
            [0, 3, 6], [1, 4, 7], [2, 5, 8],  // Columns
            [0, 4, 8], [2, 4, 6]              // Diagonals
        ]
        
        return winPatterns.contains { pattern in
            pattern.map { board[$0] }.allSatisfy { $0 == currentPlayer.rawValue }
        }
    }
    
    func replay() {
        board = Array(repeating: "", count: 9)
        currentPlayer = .x
        winner = nil
        isDraw = false
        gameStartTime = nil
        gameEndTime = nil
    }
}
