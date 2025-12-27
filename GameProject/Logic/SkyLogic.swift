//
//  SkyLogic.swift
//  GameProject
//
//  Created by Nick Gordon on 12/17/25.
//
import SpriteKit
import GameplayKit
import SwiftUI

//MARK: SkyLogic
extension GameScene {
    func createSky() {
        let topSky = SKSpriteNode(color: UIColor(hue: 0.55, saturation: 0.14, brightness: 0.97, alpha: 1), size: CGSize(width: frame.width, height: frame.height * 0.67))
        topSky.anchorPoint = CGPoint(x: 0.5, y: 1)

        let bottomSky = SKSpriteNode(color: UIColor(hue: 0.55, saturation: 0.16, brightness: 0.96, alpha: 1), size: CGSize(width: frame.width, height: frame.height * 0.33))
        bottomSky.anchorPoint = CGPoint(x: 0.5, y: 1)

        topSky.position = CGPoint(x: frame.midX, y: frame.height)
        bottomSky.position = CGPoint(x: frame.midX, y: bottomSky.frame.height)

        addChild(topSky)
        addChild(bottomSky)

        bottomSky.zPosition = -40
        topSky.zPosition = -40
    }  
}


