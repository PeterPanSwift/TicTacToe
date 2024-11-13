//
//  GridView.swift
//  TicTacToe
//
//  Created by SHIH-YING PAN on 2024/11/13.
//

import SwiftUI

struct GridView: View {
    @Environment(GameState.self) private var gameState
    @Environment(\.colorScheme) private var colorScheme
    
    let spacing: CGFloat = 10
    
    var body: some View {
        Grid(horizontalSpacing: spacing, verticalSpacing: spacing) {
            ForEach(0..<3) { row in
                GridRow {
                    ForEach(0..<3) { column in
                        CellView(index: row * 3 + column)
                    }
                }
            }
        }
        .padding()
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
}

#Preview {
    GridView()
        .environment(GameState())
}
