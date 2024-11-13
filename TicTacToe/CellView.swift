//
//  CellView.swift
//  TicTacToe
//
//  Created by SHIH-YING PAN on 2024/11/13.
//


import SwiftUI

struct CellView: View {
    @Environment(GameState.self) private var gameState
    let index: Int
    
    var body: some View {
        Button {
            withAnimation(.spring(duration: 0.5)) {
                gameState.makeMove(at: index)
            }
        } label: {
            Text(gameState.board[index])
                .font(.system(size: 50, weight: .bold))
                .foregroundStyle(cellColor)
                .frame(width: 80, height: 80)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(cellBackground)
                )
        }
        .disabled(gameState.board[index].isEmpty == false || gameState.isGameOver)
    }
    
    private var cellColor: Color {
        guard !gameState.board[index].isEmpty else { return .primary }
        return gameState.board[index] == "X" ? .blue : .pink
    }
    
    private var cellBackground: some ShapeStyle {
        if gameState.board[index].isEmpty {
            return .ultraThinMaterial
        } else {
            return .thickMaterial
        }
    }
}

#Preview {
    CellView(index: 0)
        .environment(GameState())
}
