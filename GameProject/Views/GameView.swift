//
//  ContentView.swift
//  GameProject
//
//  Created by Nick Gordon on 12/18/25.
//
import SwiftUI
import SpriteKit

struct GameView: View {
    var gameManager: GameManager

    var body: some View {
        SpriteView(scene: gameManager.scene)
            .ignoresSafeArea()
            .overlay(alignment: .topLeading) {
                HStack(alignment: .center) {
                    Image("coin")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .padding(.leading, 10)
                    
                    Text("x \(gameManager.userScore)")
                        .font(.system(size: 42, weight: .heavy, design: .rounded))
                        .shadow(color: .black.opacity(1), radius: 8, x: 0, y: 4)
                        .foregroundStyle(.yellow)
                }
                .background {
                    Rectangle()
                        .frame(width: 150)
                        .cornerRadius(16)
                }
            }
            .overlay(alignment: .topTrailing) {
                
                HStack {
                    ForEach(1...gameManager.characterLives, id: \.self) { _ in
                        Image("heart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                    }
                }
                .background {
                    Rectangle()
                        .frame(width: 180)
                        .cornerRadius(16)
                }
            }
          
    }
}

#Preview {
    GameView(gameManager: GameManager())
}


