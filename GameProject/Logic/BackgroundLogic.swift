//
//  BackgroundLogic.swift
//  GameProject
//
//  Created by Nick Gordon on 12/17/25.
//

import SpriteKit
import GameplayKit

extension GameScene {
    func createBackground(for image: String) {
        let backgroundTexture = SKTexture(imageNamed: image)
        for i in 0 ... 1 {
            let background = SKSpriteNode(texture: backgroundTexture)
            background.zPosition = -30
            background.anchorPoint = CGPoint.zero
            background.position = CGPoint(x: (backgroundTexture.size().width * CGFloat(i)) - CGFloat(1 * i), y: 0)
            addChild(background)
            let moveLeft = SKAction.moveBy(x: -backgroundTexture.size().width, y: 0, duration: 20)
            let moveReset = SKAction.moveBy(x: backgroundTexture.size().width, y: 0, duration: 0)
            let moveLoop = SKAction.sequence([moveLeft, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)

            background.run(moveForever)
        }
    }
}

import SwiftUI
#Preview {
    ContentView()
}
