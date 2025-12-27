//
//  GameScene.swift
//  GameProject
//
//  Created by Nick Gordon on 12/17/25.
//

import SpriteKit
import GameplayKit
import SwiftUI
import Observation

enum GameLevel {
    case one, two, three
}

enum GameState {
    case mainMenu
    case playingGame
    case gameOver
}

class GameScene: SKScene, SKPhysicsContactDelegate  {
    
 
    var isGrounded: Bool = true
    var player: SKSpriteNode!
    var coin: SKSpriteNode!
    var bomb: SKSpriteNode!
    var jumpButton: SKSpriteNode!
    var gameMusic: SKAudioNode!
    
    var gameState: GameState = .mainMenu
    var currentGameLevel: GameLevel = .one

    var currentCharacterSelected: CharacterSelect = .man
   
    
    var onScoreUpdate: (() -> Void)?
    var playerTakesDamage: (() -> Void)?
    var onGameStateChange: ((GameState) -> Void)?
    var onGameLevelChange: ((GameLevel) -> Void)?
    
    var buttonDown: SKAction!
    var buttonUp: SKAction!
    

    
    override func didMove(to view: SKView) {
        createCollisionBoundaries()
        createPlayer(for: currentCharacterSelected)
        createGround()

        switch currentGameLevel {
        case .one:
            createBackground(for: "city")
        case .two:
            createBackground(for: "detroitBackground")
        case .three:
            createBackground(for: "city")
        }
      
 
      
        physicsWorld.gravity = CGVector(dx: 0, dy: -5.0)
        physicsWorld.contactDelegate = self
        
        // e.g., in didMove(to:)
        //player.position = CGPoint(x: size.width * 0.4, y: player.position.y) // a bit left of center
        
        view.showsFPS = true
        view.showsNodeCount = true
        view.showsPhysics = true
        

        
        switch gameState {
        case .mainMenu:
            //player.physicsBody?.isDynamic = true
            playMusic(named: "detroitTheme", withExtension: "mp3")
        case .playingGame:
            player.physicsBody?.isDynamic = true
            playMusic(named: "music", withExtension: "m4a")
            createRockPlatforms()
           createCoins()
            createBombs()
            createControls()
        case .gameOver:
           // playMusic(named: "gameOver", withExtension: "mp3", isLooping: false) this causes a crash moved to the manager class
            speed = 0
            
          //  gameMusic.run(SKAction.stop())
        }
    }
    
    func createControls() {
        jumpButton = SKSpriteNode(imageNamed: "jumpButton")
        jumpButton.name = "jumpButton"
        jumpButton.position = CGPoint(x: size.width / 2, y: 70)
        jumpButton.zPosition = 100
        jumpButton.scale(to: CGSize(width: 100, height: 100))
        
        buttonDown = SKAction.scale(by: 0.9, duration:  0.08)
        buttonUp = SKAction.scale(by: 1.0 / 0.9, duration: 0.08)
        buttonDown.timingMode = .easeOut
        buttonUp.timingMode = .easeIn
        
        addChild(jumpButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameState == .playingGame {
            guard let touch = touches.first else { return }
            
            let location = touch.location(in: self)
            let node = atPoint(location)
            
            if node.name == "jumpButton" {
             //  if isGrounded {
                    jumpButton.run(buttonDown, withKey: "press")
                    jump()
                //   isGrounded = false
               //}
            }
        }
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
     //   if jumpButton != nil {
         //   if isGrounded {
                jumpButton.removeAction(forKey: "press")
                jumpButton.run(buttonUp, withKey: "release")
          //  }
            
      //  }
       
    }
    
    func jump() {
   
        guard let body = player.physicsBody else { return }
       // let playerTexture = SKTexture(imageNamed: "player1")
        let frame1 = SKTexture(imageNamed: "jump1")
       // let frame2 = SKTexture(imageNamed: "jump2")
        let frame3 = SKTexture(imageNamed: "jump3")
        let frame4 = SKTexture(imageNamed: "jump4")
        let animation = SKAction.animate(with: [frame1, frame4, frame3], timePerFrame: 0.1)
        let runForever = SKAction.sequence( [animation])
        let sound = SKAction.playSoundFileNamed("jump.mp3", waitForCompletion: false)
   
       
        player.run(runForever)
        run(sound)
      
        body.velocity = CGVector(dx: 100, dy: 0)
        body.applyImpulse(CGVector(dx: 20, dy: 200))
       
    }
    
//    func jump() {
//        
//        // Add to GameScene class (near other properties)
//        let jumpFrame1 = SKTexture(imageNamed: "jump1")
//        let jumpFrame2 = SKTexture(imageNamed: "jump2") // airborne
//        let jumpFrame3 = SKTexture(imageNamed: "jump3")
//     let jumpFrame4 = SKTexture(imageNamed: "jump4") // landing/grounded
//       let idleTexture = SKTexture(imageNamed: "player1") // or your idle/run base
//        // play sound and apply physics
//        let sound = SKAction.playSoundFileNamed("jump.mp3", waitForCompletion: false)
//        run(sound)
//
//        guard let body = player.physicsBody else { return }
//
//        // Only allow jump if grounded (optional, but common)
//        if isGrounded {
//            // Takeoff impulse
//            body.velocity = CGVector(dx: 100, dy: 0)
//            body.applyImpulse(CGVector(dx: 20, dy: 200))
//
//            // Set airborne state
//            isGrounded = false
//
//            // Optional: a quick takeoff pose then airborne
//            player.texture = jumpFrame1
//            // after a short delay, switch to the airborne frame and keep it
//            let toAir = SKAction.run { [weak self] in
//                self?.player.texture = jumpFrame2
//            }
//            let waitShort = SKAction.wait(forDuration: 0.06)
//            player.run(SKAction.sequence([waitShort, toAir]), withKey: "jumpTransition")
//        }
//    }
    
    /*
     update() method, which is called by SpriteKit once every frame so we can update our game world with any custom logic
     */
    override func update(_ currentTime: TimeInterval) {
        
        let value = player.physicsBody!.velocity.dy * 0.001
        let rotate = SKAction.rotate(toAngle: value, duration: 0.1)
        player.run(rotate)
       
    }
    
    /*
     It checks to see whether the contact's bodyA or bodyB property was a score detection rectangle. This is because we don't know whether the player collided with the rectangle or the rectangle collided with the player. That might sound weirdly philosophical, but trust me: it matters.
     When you first play a sound in the simulator, expect your game to pause for half a second while the sound engine is initialized. This doesn't happen on devices, but it does make this game extremely hard – at least until we fix it in the next chapter.
     Adding one to the score property triggers the didSet property observer we created earlier, which means the score label will be updated.
     I added a return line to the end because if the player collides with anything else we want to destroy them. This just means, "you hit something safe; don't continue in this method."
     The guard at the end avoids a common problem. When the player hits a “scoreDetect” node it’s possible two collisions are triggered: “player hit score detect” and “score detect hit player”. The first time our code works, but the second time the “scoreDetect” node has been removed so the game considers the player destroyed. The guard avoids that by skipping any collisions where either node has become nil.
     */
    
    func didBegin(_ contact: SKPhysicsContact) {

        guard let nodeA = contact.bodyA.node, let nodeB = contact.bodyB.node else { return }

        // Check for coin collision
        if nodeA.name == "coin" || nodeB.name == "coin" {

            let coinNode = nodeA.name == "coin" ? nodeA : nodeB
            let playerNode = nodeA == coinNode ? nodeB : nodeA

            // Ensure this coin hasn't already been collected
            if coinNode.userData?["collected"] as? Bool == true {
                return
            }

            // Mark coin as collected
            if coinNode.userData == nil { coinNode.userData = [:] }
            coinNode.userData?["collected"] = true

            // Remove the coin and play sound
            coinNode.removeFromParent()
            let sound = SKAction.playSoundFileNamed("coin.wav", waitForCompletion: false)
            run(sound)

            onScoreUpdate?()
            return
        }
        
        if nodeA.name == "bomb" || nodeB.name == "bomb" {

            let coinNode = nodeA.name == "bomb" ? nodeA : nodeB
            let playerNode = nodeA == coinNode ? nodeB : nodeA

            // Ensure this coin hasn't already been collected
            if coinNode.userData?["collected"] as? Bool == true {
                return
            }

            // Mark coin as collected
            if coinNode.userData == nil { coinNode.userData = [:] }
            coinNode.userData?["collected"] = true

            // Remove the coin and play sound
            coinNode.removeFromParent()
            let sound = SKAction.playSoundFileNamed("explosion.wav", waitForCompletion: false)
            run(sound)

            playerTakesDamage?()
            return
        }
        
        if nodeA.name == "ground" || nodeB.name == "ground" {

            let coinNode = nodeA.name == "ground" ? nodeA : nodeB
            let playerNode = nodeA == coinNode ? nodeB : nodeA

            // Ensure this coin hasn't already been collected
            if coinNode.userData?["collected"] as? Bool == true {
                return
            }

            // Mark coin as collected
            if coinNode.userData == nil { coinNode.userData = [:] }
            coinNode.userData?["collected"] = true

            isGrounded = true
            // Remove the coin and play sound
           // coinNode.removeFromParent()
//            let sound = SKAction.playSoundFileNamed("explosion.wav", waitForCompletion: false)
//            run(sound)

            //playerTakesDamage?()
            return
        }
    }
    
    func updateCharacter(to character: CharacterSelect) {
        // preserve important state
        let oldPosition = player?.position ?? CGPoint(x: size.width * 0.4, y: size.height * 0.5)
        let oldZ = player?.zPosition ?? 10
        let oldVelocity = player?.physicsBody?.velocity

        player?.removeAllActions()
        player?.removeFromParent()

       // createPlayer(for: character)

        // restore state on the new sprite
        player.position = oldPosition
        player.zPosition = oldZ
        if let v = oldVelocity {
            player.physicsBody?.velocity = v
        }
    }

    
//    func updateGameState(to state: GameState) {
//        self.gameState = state
//
//        switch state {
//        case .mainMenu:
//            // If you need to remove gameplay nodes and show menu, do it here.
//            // e.g., remove platforms/coins/bombs, stop game actions, play menu music
//            playMusic(named: "detroitTheme", withExtension: "mp3")
//        case .playingGame:
//            // Ensure base world is ready
//            if childNode(withName: "ground") == nil {
//                createCollisionBoundaries()
//                createGround()
//            }
//            // Create gameplay elements if not already present
//            createRockPlatforms()
//            createCoins()
//            createBombs()
//            createControls()
//            playMusic(named: "music", withExtension: "m4a")
//            player.physicsBody?.isDynamic = true
//        case .gameOver:
//            speed = 0
//            // optionally clean up or show game over UI
//        }
//    }
}


import SwiftUI
#Preview {
    ContentView()
}

