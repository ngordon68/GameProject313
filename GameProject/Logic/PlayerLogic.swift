//
//  PlayerLogic.swift
//  GameProject
//
//  Created by Nick Gordon on 12/17/25.
//
import SpriteKit
import GameplayKit

//extension GameScene {
//    func createPlayer(for currentCharacter:CharacterSelect) {
//   
//        
//        let frames = currentCharacter.idleFrames
//        let playerTexture = frames[0]
//       // let playerTexture = SKTexture(imageNamed: "girlFrame1")
//     
//        player = SKSpriteNode(texture: playerTexture)
//        player.zPosition = 10
//        player.position = CGPoint(x: frame.width / 2, y: frame.height * 0.33)
//      //  player.position = CGPoint(x: frame.width / 2, y: frame.height * 1)
//       // player.xScale = playerSize
//       // player.yScale = playerSize
//         player.scale(to: CGSize(width: 100, height: 100))
//        //player.physicsBody?.node = frame(width: 100, height: 100)
//        let newSize = CGSize(width: 100, height: 100)
//     
//       
//        
//        addChild(player)
//        
//        /*
//         Those four lines of code pack in a lot of functionality, and might not make sense right away so let me break it down:
//
//         The first line sets up pixel-perfect physics using the sprite of the plane. This sprite animates, but the difference is so tiny it won't matter.
//         The second line makes SpriteKit tell us whenever the player collides with anything. This is wasteful in some games, but here the player dies if they touch anything so it's the right thing to do.
//         The third line makes the plane respond to physics. This is the default, but I'm including it here because we'll change it later.
//         The last line makes the plane bounce off nothing, or at least it would do if it weren't commented out. I've made it commented out just for a moment so you can see it's working – I'll tell you when to remove the comment.
//         */
//       // player.physicsBody = SKPhysicsBody(texture: playerTexture, size: playerTexture.size())
//        player.physicsBody = SKPhysicsBody(rectangleOf: newSize)
//        player.physicsBody!.contactTestBitMask = player.physicsBody!.collisionBitMask
//        player.physicsBody?.isDynamic = false
//        //player.physicsBody?.collisionBitMask = 1
//
//        let frame2 = SKTexture(imageNamed: "player2")
//        let frame3 = SKTexture(imageNamed: "player3")
//        let animation = SKAction.animate(with: [playerTexture, frame2, frame3, frame2], timePerFrame: 0.1)
//        let runForever = SKAction.repeatForever(animation)
//        
//        player.run(runForever)
//        
//    }
//}
extension GameScene {
    func createPlayer(for currentCharacter: CharacterSelect) {

        let frames = currentCharacter.idleFrames
        let playerTexture = frames[0]

        player = SKSpriteNode(texture: playerTexture)
        player.zPosition = 10
        player.position = CGPoint(x: frame.width / 2, y: frame.height * 0.33)
        player.scale(to: CGSize(width: 100, height: 100))

        addChild(player)

        let physicsSize = CGSize(width: 100, height: 100)
        player.physicsBody = SKPhysicsBody(rectangleOf: physicsSize)
        player.physicsBody?.contactTestBitMask = player.physicsBody?.collisionBitMask ?? 0
        player.physicsBody?.isDynamic = false

        let animation = SKAction.animate(with: frames, timePerFrame: 0.1)
        let runForever = SKAction.repeatForever(animation)
        player.run(runForever)
    }
}


import SwiftUI
#Preview {
    ContentView()
}


extension CharacterSelect {
    var idleFrames: [SKTexture] {
        switch self {
        case .woman:
            return [
                SKTexture(imageNamed: "girlFrame1"),
                SKTexture(imageNamed: "girlFrame2"),
                SKTexture(imageNamed: "girlFrame3"),
                SKTexture(imageNamed: "girlFrame2")
            ]

        case .man:
            return [
                SKTexture(imageNamed: "player1"),
                SKTexture(imageNamed: "player2"),
                SKTexture(imageNamed: "player3"),
                SKTexture(imageNamed: "player2")
            ]
        }
    }
}
