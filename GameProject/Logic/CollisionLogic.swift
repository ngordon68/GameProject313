//
//  CollisionLogic.swift
//  GameProject
//
//  Created by Nick Gordon on 12/23/25.
//

import SpriteKit
import GameplayKit
import SwiftUI

extension GameScene {
    func createCollisionBoundaries() {
        
        let leftCollisionBoundary = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 10, height: frame.size.height * 2))
        leftCollisionBoundary.physicsBody = SKPhysicsBody(rectangleOf: leftCollisionBoundary.size)
        leftCollisionBoundary.physicsBody?.isDynamic = false
        leftCollisionBoundary.position.x = 0
        
        let rightCollisionBoundary = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 10, height: frame.size.height * 2))
        rightCollisionBoundary.physicsBody = SKPhysicsBody(rectangleOf: rightCollisionBoundary.size)
        rightCollisionBoundary.physicsBody?.isDynamic = false
        rightCollisionBoundary.position.x = frame.width
        
        let topCollisionBoundary = SKSpriteNode(color: UIColor.clear, size: CGSize(width: frame.size.width * 2, height: 10))
        topCollisionBoundary.physicsBody = SKPhysicsBody(rectangleOf: topCollisionBoundary.size)
        topCollisionBoundary.physicsBody?.isDynamic = false
        topCollisionBoundary.position.y = frame.width
        topCollisionBoundary.position.y = frame.height
    
        addChild(topCollisionBoundary)
        addChild(leftCollisionBoundary)
        addChild(rightCollisionBoundary)
    }
    
    
}

#Preview {
    ContentView()
}
