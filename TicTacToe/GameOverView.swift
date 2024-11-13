//
//  GameOverView.swift
//  TicTacToe
//
//  Created by SHIH-YING PAN on 2024/11/13.
//

import SwiftUI

struct GameOverView: View {
    @Environment(GameState.self) private var gameState
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(spacing: 25) {
            Text(gameOverMessage)
                .font(.title)
                .bold()
                .foregroundStyle(gameOverColor)
            
            Button {
                withAnimation {
                    gameState.replay()
                }
            } label: {
                Text("New Game")
                    .font(.title3)
                    .bold()
                    .frame(width: 200)
                    .padding()
                    .background(
                        Capsule()
                            .fill(.purple.gradient)
                    )
                    .foregroundStyle(.white)
                    .shadow(radius: 10)
            }
        }
        .padding(.vertical, 30)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .shadow(
                    color: colorScheme == .dark ?
                        .white.opacity(0.1) : .black.opacity(0.1),
                    radius: 15
                )
        )
    }
    
    private var gameOverMessage: String {
        if let winner = gameState.winner {
            return "Player \(winner.rawValue) Wins!"
        } else {
            return "Game Draw!"
        }
    }
    
    private var gameOverColor: Color {
        if let winner = gameState.winner {
            return winner.color
        } else {
            return .orange
        }
    }
}

#Preview {
    GameOverView()
        .environment(GameState())
}
