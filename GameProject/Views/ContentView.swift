//
//  ContentView.swift
//  GameProject
//
//  Created by Nick Gordon on 12/19/25.
//

import SwiftUI

struct ContentView: View {
  @State var gameManager = GameManager()
    var body: some View {
       switch gameManager.gameState {
       case .mainMenu:
           MainMenuView(gameManager: gameManager)
       case .playingGame:
           GameView(gameManager: gameManager)
       default:
           SummaryView(gameManager: gameManager)
           
        }
    }
}

#Preview {
    ContentView()
}




