//
//  GameSceneStore.swift
//  GameProject
//
//  Created by Nick Gordon on 12/19/25.
//

import SwiftUI
import Observation
import SpriteKit

enum CharacterSelect: String, CaseIterable {
    case man, woman
}

@Observable
class GameManager {
    var userScore = 0
    var gameState: GameState = .mainMenu
    var currentGameLevel: GameLevel = .one
    var characterLives = 3
    var didWinCurrentLevel = false
    var currentCharacterSelection: CharacterSelect = .man
        
    
//    var scene = GameScene()
//    
//    init() {
//        
//    }
    var scene: SKScene {
        let scene = GameScene()
        scene.scaleMode = .resizeFill
        scene.currentGameLevel = currentGameLevel
        scene.currentCharacterSelected = currentCharacterSelection
     
        
        scene.onScoreUpdate = { [weak self] in
            self?.userScore += 1
            self?.checkIFGameOver()
        }
        scene.gameState = gameState
              scene.onGameStateChange = { [weak self] newState in
                  self?.gameState = newState
              }
        
        scene.playerTakesDamage = { [weak self] in
            self?.characterLives -= 1
        }
        return scene
    }

//    func configureScene() {
//        scene.scaleMode = .resizeFill
//        scene.currentGameLevel = currentGameLevel
//        scene.currentCharacterSelected = currentCharacterSelection
//        scene.gameState = gameState
//
//        scene.onScoreUpdate = { [weak self] in
//            self?.userScore += 1
//            self?.checkIFGameOver()
//        }
//
//        scene.onGameStateChange = { [weak self] newState in
//            self?.gameState = newState
//        }
//
//        scene.playerTakesDamage = { [weak self] in
//            self?.characterLives -= 1
//        }
//    }

    func checkIFGameOver() {
        if userScore >= 20 {
            didWinCurrentLevel = true
            gameState = .gameOver
            playSound(sound: "levelComplete", type: "mp3")
            
        }
        
        if characterLives <= 1 {
            didWinCurrentLevel = false
            gameState = .gameOver
            playSound(sound: "gameOver", type: "mp3")
        }
        
        
    }
    func nextLevel() {
        characterLives = 3
        userScore = 0
        gameState = .playingGame
        currentGameLevel = .two
    }
    
    func playAgain() {
        didWinCurrentLevel = false
        characterLives = 3
        userScore = 0
        gameState = .playingGame
    }
    func backToMainMenu() {
        characterLives = 3
        userScore = 0
        gameState = .mainMenu
        
    }
}

import SwiftUI
#Preview {
    ContentView()
}

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("ERROR")
        }
    }
}
