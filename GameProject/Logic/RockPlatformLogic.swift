//
//  RockPlatformLogic.swift
//  GameProject
//
//  Created by Nick Gordon on 12/20/25.
//
import SpriteKit

extension  GameScene {
    func createRockPlatform() {
        // 1
        let rockTexture = SKTexture(imageNamed: "rockPlatform")
  
        
        let newSize = CGSize(width: 100, height: 100)
        let bottomRock = SKSpriteNode(texture: rockTexture)
        bottomRock.physicsBody = SKPhysicsBody(rectangleOf: newSize)
        
       
        bottomRock.zPosition = 0
      
      //  bottomRock.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        bottomRock.scale(to: CGSize(width: 100, height: 100))

        //bottomRock.xScale = -1
//        bottomRock.physicsBody = SKPhysicsBody(texture: rockTexture, size: rockTexture.size())
        bottomRock.physicsBody?.isDynamic = false
        
        // 2
        let rockCollision = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 32, height: frame.height))
       // rockCollision.name = "scoreDetect"
        rockCollision.physicsBody = SKPhysicsBody(rectangleOf: rockCollision.size)
        rockCollision.physicsBody?.isDynamic = false
        
        addChild(bottomRock)
     
        
        // 3
        let xPosition = frame.width + bottomRock.frame.width
        
        let max = CGFloat(frame.height / 2)
        let yPosition = CGFloat.random(in: 200...max)
        
        // this next value affects the width of the gap between rocks
        // make it smaller to make your game harder – if you're feeling evil!
        let rockDistance: CGFloat = 70
        bottomRock.position = CGPoint(x: xPosition, y: yPosition)
        //rockCollision.position = CGPoint(x: xPosition + (rockCollision.size.width * 2), y: frame.midY)
        
        let endPosition = frame.width + (bottomRock.frame.width * 2)
        
        let moveAction = SKAction.moveBy(x: -endPosition, y: 0, duration: 6.2)
        let moveSequence = SKAction.sequence([moveAction, SKAction.removeFromParent()])
        bottomRock.run(moveSequence)
    }
    
    func createRockPlatforms() {
        let create = SKAction.run { [unowned self] in
            self.createRockPlatform( )
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

