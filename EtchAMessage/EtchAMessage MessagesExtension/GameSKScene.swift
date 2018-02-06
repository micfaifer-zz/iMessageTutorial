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
    var currentDirection = ""
    var isTouchingX = false
    var isTouchingY = false
    
    //MARK: - Scene Initialization
    override func didMove(to view: SKView) {
        let leftNode = SKSpriteNode(color: .red, size: CGSize(width: (self.view?.frame.size.width)!/2, height: self.size.height/2))
//            SKSpriteNode(texture: SKTexture(imageNamed: "castelo-2"), color: .white, size: self.size)
        leftNode.position = self.position
//        leftNode.zPosition = -4
        leftNode.name = "XButton"
        self.addChild(leftNode)
        
        let rightNode = SKSpriteNode(color: .blue, size: CGSize(width: self.size.width/2, height: self.size.height/2))
        let positionX = self.position.x + self.size.width
        let positionY = self.position.y
        rightNode.position = CGPoint(x: positionX, y: positionY)
//        rightNode.zPosition = -4
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
                    self.handlePanX(recognizer: recognizer)
                } else if name.contains("YButton") {
                    self.handlePanY(recognizer: recognizer)
                }
            }
        }
    }
    
    func handlePanX(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            isTouchingX = true
            previousPoint.x = recognizer.translation(in: self.view).x
        case .changed:
            if (abs(previousPoint.x - recognizer.translation(in: self.view).x) <= 30) {
                return
            } else if previousPoint.x < recognizer.translation(in: self.view).x {
                print("dir")
                self.currentDirection = "right"
                self.drawLine(to: self.currentDirection)
            } else {
                print("esq")
                self.currentDirection = "left"
                self.drawLine(to: self.currentDirection)
            }
        case .ended:
            isTouchingX = false
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        default:
            return
        }
    }
    
    func handlePanY(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            isTouchingY = true
            previousPoint.y = recognizer.translation(in: self.view).y
        case .changed:
            if (abs(previousPoint.y - recognizer.translation(in: self.view).y) <= 30) {
                return
            } else if previousPoint.y < recognizer.translation(in: self.view).y {
                print("up")
                self.currentDirection = "up"
                self.drawLine(to: self.currentDirection)
            } else {
                print("down")
                self.currentDirection = "down"
                self.drawLine(to: self.currentDirection)
            }
        case .ended:
            isTouchingY = false
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        default:
            return
        }
    }
    
    func drawLine(to direction: String){
        let path = UIBezierPath()
        
        path.move(to: previousPoint)
        path.addLine(to: CGPoint(x: previousPoint.x+30, y: previousPoint.y))
        /*
        if direction == "right"{
            path.addLine(to: CGPoint(x: previousPoint.x+30, y: previousPoint.y))
            previousPoint.x += 30
        } else if direction == "left" {
            path.addLine(to: CGPoint(x: previousPoint.x-30, y: previousPoint.y))
            previousPoint.x -= 30
        } else if direction == "up" {
            path.addLine(to: CGPoint(x: previousPoint.x, y: previousPoint.y+30))
            previousPoint.y += 30
        } else if direction == "down" {
            path.addLine(to: CGPoint(x: previousPoint.x, y: previousPoint.y-30))
            previousPoint.y -= 30
        }
 */
        
        let shapeNode = SKShapeNode(path: path.cgPath)
//        shapeNode.fillColor = .clear
        shapeNode.strokeColor = UIColor.green
        shapeNode.lineWidth = 1
        
        self.addChild(shapeNode)
    }
    
    override func update(_ currentTime: TimeInterval) {
        /*
        //Desenhar infinitamente a linha
        if isTouchingX {
            self.drawLine(to: self.currentDirection)
        }
        if isTouchingY {
            self.drawLine(to: self.currentDirection)
        }
 */
    }
}
