//
//  DrawViewController.swift
//  EtchAMessage MessagesExtension
//
//  Created by Piera Marchesini on 05/02/18.
//  Copyright © 2018 Piera Marchesini. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {
    
    var firstTranslationX: CGPoint?
    var firstTranslationY: CGPoint?
    var previousPath: CGPoint = CGPoint(x: 0, y: 100)
    var isTouching = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handlePanX(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            firstTranslationX = recognizer.translation(in: self.view)
        case .changed:
            guard let first = firstTranslationX else { return }
            if (abs(first.x - recognizer.translation(in: self.view).x) <= 30) {
                return
            } else if first.x < recognizer.translation(in: self.view).x {
                print("dir")
                OperationQueue.main.addOperation({
                    self.drawLine()
                })
                
            } else {
                //TODO: - Desenhar a linha para a ESQUERDA
                print("esq")
            }
        case .ended:
            OperationQueue.main.cancelAllOperations()
            isTouching = false
//           x previousPath.x = previousPath.x+recognizer.translation(in: self.view).x
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        default:
            print("ta aqui?")
            return
        }
        print("oi")
    }
    
    func drawLine(){
        
        repeat {
            if self.isTouching {
                print("teste")
                let path = UIBezierPath()
                path.move(to: previousPath)
                path.addLine(to: CGPoint(x: previousPath.x+30, y: previousPath.y))
                let layer = CAShapeLayer()
                layer.strokeColor = UIColor.black.cgColor
                layer.lineWidth = 2
                layer.path = path.cgPath
                self.view.layer.addSublayer(layer)
                
                previousPath.x += 30
            } else {
                return
            }
        } while self.isTouching
        
    }

    @IBAction func handlePanY(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            firstTranslationY = recognizer.translation(in: self.view)
        case .changed:
            guard let first = firstTranslationY else { return }
            if (abs(first.y - recognizer.translation(in: self.view).y) <= 30) {
                return
            } else if first.y > recognizer.translation(in: self.view).y {
                print("cim")
                //TODO: - Desenhar a linha para CIMA
            } else {
                //TODO: - Desenhar a linha para BAIXO
                print("baix")
            }
        case .ended:
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        default:
            return
        }
    }
}
