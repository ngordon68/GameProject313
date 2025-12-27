//
//  Coin.swift
//  GameProject
//
//  Created by Nick Gordon on 12/23/25.
//
import SpriteKit

extension GameScene {
    func createCoin() {
        // 1
        let coinTexture = SKTexture(imageNamed: "coin")
        let newSize = CGSize(width: 100, height: 100)
        coin = SKSpriteNode(texture: coinTexture)
        coin.name = "coin"
        coin.physicsBody = SKPhysicsBody(texture: coinTexture, size: coinTexture.size())
        coin.zPosition = 0
        coin.scale(to: CGSize(width: 50, height: 50))
        coin.physicsBody?.isDynamic = false
        //coin.physicsBody?.collisionBitMask = 0
        addChild(coin)
        
        let xPosition = frame.width + coin.frame.width
        
        let max = CGFloat(frame.height / 2)
        let yPosition = CGFloat.random(in: 200...max)
        
        // this next value affects the width of the gap between rocks
        // make it smaller to make your game harder – if you're feeling evil!
        let rockDistance: CGFloat = 70
        coin.position = CGPoint(x: xPosition, y: yPosition)
        //rockCollision.position = CGPoint(x: xPosition + (rockCollision.size.width * 2), y: frame.midY)
        
        let endPosition = frame.width + (coin.frame.width * 2)
        
        let moveAction = SKAction.moveBy(x: -endPosition, y: 0, duration: 6.2)
        let moveSequence = SKAction.sequence([moveAction, SKAction.removeFromParent()])
        coin.run(moveSequence)
    }
    
    func createCoins() {
        let create = SKAction.run { [unowned self] in
            self.createCoin()
        }
        
        let wait = SKAction.wait(forDuration: 2)
        let sequence = SKAction.sequence([create, wait])
        let repeatForever = SKAction.repeatForever(sequence)
        
        run(repeatForever)
    }
}
