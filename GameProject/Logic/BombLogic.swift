//
//  BombLogic.swift
//  GameProject
//
//  Created by Nick Gordon on 12/23/25.
//

import SpriteKit




extension GameScene {
    func createBomb() {
        // 1
        let bombTexture = SKTexture(imageNamed: "bomb")
        let newSize = CGSize(width: 100, height: 100)
        bomb = SKSpriteNode(texture: bombTexture)
        bomb.name = "bomb"
        bomb.physicsBody = SKPhysicsBody(texture: bombTexture, size: bombTexture.size())
        bomb.zPosition = 0
        bomb.scale(to: CGSize(width: 100, height: 100))
        bomb.physicsBody?.isDynamic = false
        //coin.physicsBody?.collisionBitMask = 0
        addChild(bomb)
        
        let xPosition = frame.width + bomb.frame.width
        
        let max = CGFloat(frame.height / 2)
        let yPosition = CGFloat.random(in: 200...max)
        
        // this next value affects the width of the gap between rocks
        // make it smaller to make your game harder – if you're feeling evil!
        let rockDistance: CGFloat = 70
        bomb.position = CGPoint(x: xPosition, y: yPosition)
        //rockCollision.position = CGPoint(x: xPosition + (rockCollision.size.width * 2), y: frame.midY)
        
        let endPosition = frame.width + (bomb.frame.width * 2)
        
        let moveAction = SKAction.moveBy(x: -endPosition, y: 0, duration: 6.2)
        let moveSequence = SKAction.sequence([moveAction, SKAction.removeFromParent()])
        bomb.run(moveSequence)
    }
    
    func createBombs() {
        let create = SKAction.run { [unowned self] in
            self.createBomb()
        }
        
        let wait = SKAction.wait(forDuration: 2)
        let sequence = SKAction.sequence([create, wait])
        let repeatForever = SKAction.repeatForever(sequence)
        
        run(repeatForever)
    }
}

import SwiftUI
#Preview {
    ContentView()
}
