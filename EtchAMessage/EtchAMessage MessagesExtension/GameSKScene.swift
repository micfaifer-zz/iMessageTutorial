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
        let leftNode = SKSpriteNode(color: .red, size: self.size)
//            SKSpriteNode(texture: SKTexture(imageNamed: "castelo-2"), color: .white, size: self.size)
        leftNode.position = self.position
        leftNode.zPosition = -4
        leftNode.name = "XButton"
        self.addChild(leftNode)
        
        let rightNode = SKSpriteNode(color: .blue, size: self.size)
        let positionX = self.position.x + self.size.width
        let positionY = self.position.y
        rightNode.position = CGPoint(x: positionX, y: positionY)
        rightNode.zPosition = -4
        rightNode.name = "YButton"
        self.addChild(rightNode)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanFrom(recognizer:)))
        self.view!.addGestureRecognizer(panGestureRecognizer)
    }
    
    //MARK: - Handle Pan
    @objc func handlePanFrom(recognizer: UIPanGestureRecognizer) {
        guard let scene = self.scene else { return }
        for children in scene.children {
            if let name = children.name {
                if name.contains("XButton") {
                    
                } else if name.contains("YButton") {
                    
                }
            }
        }
    }
    
    func handlePanX(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            previousPoint.x = recognizer.translation(in: self.view).x
        case .changed:
            if (abs(previousPoint.x - recognizer.translation(in: self.view).x) <= 30) {
                return
            } else if previousPoint.x < recognizer.translation(in: self.view).x {
                print("dir")
                self.drawLine(to: "x")
            } else {
                //TODO: - Desenhar a linha para a ESQUERDA
                print("esq")
            }
        case .ended:
            OperationQueue.main.cancelAllOperations()
            isTouchingX = false
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        default:
            return
        }
    }
    
    func drawLine(to axis: String, ){
        let path = UIBezierPath()
        path.move(to: previousPoint)
        if axis == "x"{
            path.addLine(to: CGPoint(x: previousPoint.x+30, y: previousPoint.y))
        } else if axis == "y" {
            path.addLine(to: CGPoint(x: previousPoint.x, y: previousPoint.y+30))
        }
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.black.cgColor
        layer.lineWidth = 2
        layer.path = path.cgPath
        self.view.layer.addSublayer(layer)
        previousPoint.x += 30
    }
    
    override func update(_ currentTime: TimeInterval) {
        //Desenhar infinitamente a linha
        if isTouchingX {
            self.drawLine()
        }
        if isTouchingY {
            
        }
    }
}
