//
//  SummaryView.swift
//  GameProject
//
//  Created by Nick Gordon on 12/19/25.
//

import SwiftUI
import SpriteKit

struct SummaryView: View {
    
    var gameManager: GameManager
    
    var body: some View {
        ZStack {
            SpriteView(scene: gameManager.scene)
                .ignoresSafeArea()
                .blur(radius: 2)
                .opacity(0.9)

        
            VStack(spacing: 16) {
                Text(gameManager.didWinCurrentLevel ? "You Won!" : "Better Luck Next Time!")
                    .font(.largeTitle).bold()

                Text("You scored \(gameManager.userScore) points.")
                    .font(.title3)
                    .foregroundStyle(.secondary)

                Text(encouragement(for: gameManager.userScore))
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.top, 4)
                
                Button {
            
                    gameManager.nextLevel()
                } label: {
                    Text("Next Level")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .controlSize(.large)

                Button {
                    gameManager.playAgain()
                } label: {
                    Text("Play Again")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .controlSize(.large)
                
                Button {
            
                    gameManager.backToMainMenu()
                    gameManager.currentGameLevel = .one
                } label: {
                    Text("Main Menu")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .controlSize(.large)
            }
            .padding(24)
            .frame(maxWidth: 360)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(.ultraThickMaterial)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .strokeBorder(Color.white.opacity(0.15))
            )
            .shadow(color: .black.opacity(0.25), radius: 24, x: 0, y: 12)
            .padding()
        }
    }
}

private extension SummaryView {
    func encouragement(for score: Int) -> String {
        switch score {
        case 0:
            return "Tough start — give it another go!"
        case 1...5:
            return "Nice! You’re getting the hang of it."
        case 6...15:
            return "Great job! Keep pushing your high score."
        case 16...30:
            return "Awesome run! You’re on fire!"
        default:
            return "Legendary! That’s an incredible score!"
        }
    }
}

#Preview {
    SummaryView(gameManager: GameManager())
}

