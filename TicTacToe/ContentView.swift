//
//  ContentView.swift
//  TicTacToe
//
//  Created by SHIH-YING PAN on 2024/11/13.
//


import SwiftUI

struct ContentView: View {
    @Environment(GameState.self) private var gameState
    @State private var timeElapsed: TimeInterval = 0
    @Environment(\.colorScheme) private var colorScheme
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                headerView
                gameStatusView
                GridView()
                if gameState.isGameOver {
                    GameOverView()
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .padding()
        }
        .onReceive(timer) { _ in
            if !gameState.isGameOver {
                timeElapsed = gameState.elapsedTime
            }
        }
        .animation(.spring(duration: 0.6), value: gameState.isGameOver)
    }
    
    private var headerView: some View {
        Text("Tic Tac Toe")
            .font(.system(size: 40, weight: .bold))
            .foregroundStyle(
                .linearGradient(
                    colors: [.blue, .purple],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
    }
    
    private var gameStatusView: some View {
        VStack(spacing: 15) {
            TimelineView(.animation) { _ in
                Text(formattedTime)
                    .font(.system(.title3, design: .monospaced))
                    .bold()
                    .foregroundStyle(.secondary)
            }
            
            if !gameState.isGameOver {
                HStack(spacing: 15) {
                    Text("Current Player:")
                        .foregroundStyle(.secondary)
                    Text(gameState.currentPlayer.rawValue)
                        .font(.title2)
                        .bold()
                        .foregroundStyle(gameState.currentPlayer.color)
                        .frame(width: 40, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.ultraThinMaterial)
                        )
                }
            }
        }
    }
    
    private var backgroundGradient: some View {
        LinearGradient(
            colors: colorScheme == .dark ?
            [Color(white: 0.1), Color(white: 0.15)] :
                [.white, Color(white: 0.95)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    private var formattedTime: String {
        let minutes = Int(timeElapsed) / 60
        let seconds = Int(timeElapsed) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    ContentView()
        .environment(GameState())
}
