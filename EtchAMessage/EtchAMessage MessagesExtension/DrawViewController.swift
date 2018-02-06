//
//  DrawViewController.swift
//  EtchAMessage MessagesExtension
//
//  Created by Piera Marchesini on 05/02/18.
//  Copyright © 2018 Piera Marchesini. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {
    
    var previousPoint = CGPoint(x: 0, y: 100)
    var currentDirection = ""
    var beganPoint: CGPoint?
    
    var timerX: Timer?
    var timerY: Timer?
    
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
            beganPoint = recognizer.translation(in: self.view)
        case .changed:
            guard let began = beganPoint else { return }
            if (abs(began.x - recognizer.translation(in: self.view).x) <= 30) {
                return
            } else if began.x < recognizer.translation(in: self.view).x {
                print("dir")
                self.currentDirection = "right"
                //START TIMER
                self.startTimerX()
            } else {
                print("esq")
                self.currentDirection = "left"
                //START TIMER
                self.startTimerX()
            }
        case .ended:
            print("parooooou")
            self.stopTimerX()
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        default:
            return
        }
    }

    @IBAction func handlePanY(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            beganPoint = recognizer.translation(in: self.view)
        case .changed:
            guard let began = beganPoint else { return }
            if (abs(began.y - recognizer.translation(in: self.view).y) <= 30) {
                return
            } else if began.y > recognizer.translation(in: self.view).y {
                print("up")
                self.currentDirection = "up"
                //START TIMER
                self.startTimerY()
            } else {
                print("down")
                self.currentDirection = "down"
                //START TIMER
                self.startTimerY()
            }
        case .ended:
            self.stopTimerY()
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        default:
            return
        }
    }
    
    @objc
    func drawXLine(){
        let path = UIBezierPath()
        path.move(to: previousPoint)
        if currentDirection == "right"{
            path.addLine(to: CGPoint(x: previousPoint.x+2, y: previousPoint.y))
            previousPoint.x += 2
        } else if currentDirection == "left" {
            path.addLine(to: CGPoint(x: previousPoint.x-2, y: previousPoint.y))
            previousPoint.x -= 2
        }
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.black.cgColor
        layer.lineWidth = 2
        layer.path = path.cgPath
        DispatchQueue.main.async {
            self.view.layer.addSublayer(layer)
        }
    }
    
    @objc
    func drawYLine(){
        let path = UIBezierPath()
        path.move(to: previousPoint)
        if currentDirection == "up"{
            path.addLine(to: CGPoint(x: previousPoint.x, y: previousPoint.y+2))
            previousPoint.y += 2
        } else if currentDirection == "down" {
            path.addLine(to: CGPoint(x: previousPoint.x, y: previousPoint.y-2))
            previousPoint.y -= 2
        }
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.black.cgColor
        layer.lineWidth = 2
        layer.path = path.cgPath
        self.view.layer.addSublayer(layer)
    }
    
    //MARK: - Timer
    func startTimerX(){
        if self.timerX == nil {
//            self.timerX = Timer(timeInterval: 0.05, target: self, selector: #selector(DrawViewController.drawXLine), userInfo: nil, repeats: true)
            self.timerX = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(DrawViewController.drawXLine), userInfo: nil, repeats: true)
            self.timerX?.fire()
            
        }
    }
    
    func stopTimerX(){
        self.timerX?.invalidate()
        self.timerX = nil
    }
    
    func startTimerY(){
        if self.timerY == nil {
            self.timerY = Timer(timeInterval: 0.05, target: self, selector: #selector(DrawViewController.drawYLine), userInfo: nil, repeats: true)
            self.timerY?.fire()
        }
    }
    
    func stopTimerY(){
        self.timerY?.invalidate()
        self.timerY = nil
    }
}
