//
//  GameSKScene.swift
//  EtchAMessage MessagesExtension
//
//  Created by Piera Marchesini on 05/02/18.
//  Copyright © 2018 Piera Marchesini. All rights reserved.
//

import SpriteKit
import UIKit

class GameSKScene: SKScene {
    var previousPoint = CGPoint(x: 0, y: 100)
    var isTouchingX = false
    var isTouchingY = false
    
    //MARK: - Scene Initialization
    override func didMove(to view: SKView) {
        let backgroundNode = SKSpriteNode(color: .red, size: self.size)
//            SKSpriteNode(texture: SKTexture(imageNamed: "castelo-2"), color: .white, size: self.size)
        backgroundNode.position = self.position
        backgroundNode.zPosition = -4
        self.addChild(backgroundNode)
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        //Desenhar infinitamente a linha
        if isTouchingX {
            
        }
        if isTouchingY {
            
        }
    }
}
