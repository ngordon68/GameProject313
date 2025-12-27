//
//  GroundLogic.swift
//  GameProject
//
//  Created by Nick Gordon on 12/17/25.
//
import SpriteKit
import GameplayKit


extension GameScene {
    func createGround() {
        let groundTexture = SKTexture(imageNamed: "ground")
        
        for i in 0 ... 1 {
            let ground = SKSpriteNode(texture: groundTexture)
            ground.zPosition = -10
            ground.position = CGPoint(x: (groundTexture.size().width / 2.0 + (groundTexture.size().width * CGFloat(i))), y: groundTexture.size().height / 2)
            
            ground.physicsBody = SKPhysicsBody(texture: ground.texture!, size: ground.texture!.size())
            ground.physicsBody?.isDynamic = false
           //addChild(ground)
            
            
            let groundCollision = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 2000, height: 5))
           // groundCollision.name = "scoreDetect"
            groundCollision.physicsBody = SKPhysicsBody(rectangleOf: groundCollision.size)
            groundCollision.physicsBody?.isDynamic = false
            groundCollision.name = "ground"
            addChild(groundCollision)
            groundCollision.position = CGPoint(x: 0, y: 220)
            

            
            let moveLeft = SKAction.moveBy(x: -groundTexture.size().width, y: 0, duration: 5)
            let moveReset = SKAction.moveBy(x: groundTexture.size().width, y: 0, duration: 0)
            let moveLoop = SKAction.sequence([moveLeft, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)
            
            ground.run(moveForever)
          //  groundCollision.run(moveForever)
            
            //ground collision
        }
    }
}

import SwiftUI
#Preview {
    ContentView()
}
