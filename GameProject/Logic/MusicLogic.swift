//
//  MusicLogic.swift
//  GameProject
//
//  Created by Nick Gordon on 12/19/25.
//

import SpriteKit
extension GameScene {
    func playMusic(named fileName: String, withExtension ext: String, isLooping: Bool = true) {
       
        if let music = gameMusic {
              music.removeFromParent()
              gameMusic = nil
          }
        
        if let selectedSong = Bundle.main.url(forResource: fileName, withExtension: ext) {
            gameMusic = SKAudioNode(url: selectedSong)
            gameMusic.autoplayLooped = isLooping
          // addChild(gameMusic)
    
            if !isLooping {
                gameMusic.run(SKAction.play())
            }
        }
        
        
//MARK: put the optional check for looping out here whiched caused crashed
          
            
        }

    }


import SwiftUI
#Preview {
    ContentView()
}


