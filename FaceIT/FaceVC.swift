//
//  ViewController.swift
//  FaceIT
//
//  Created by Ulan Assanov on 11/20/17.
//  Copyright © 2017 Ulan Assanov. All rights reserved.
//

import UIKit

class FaceVC: UIViewController {
    @IBOutlet weak var faceView: FaceView!{ // Implicitly unwrapped object
        didSet{
            let handler = #selector(FaceView.changeScale(byReactingTo:))
            let pinchRecognizer = UIPinchGestureRecognizer(target: faceView, action: handler)
            faceView.addGestureRecognizer(pinchRecognizer)
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.toogleEyes(byReactingTo:)))
            tapRecognizer.numberOfTapsRequired = 1
            faceView.addGestureRecognizer(tapRecognizer)
            let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(increaseHappiness))
            swipeUpRecognizer.direction = .up
            faceView.addGestureRecognizer(swipeUpRecognizer)
            let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(decreaseHappiness))
            swipeDownRecognizer.direction = .down
            faceView.addGestureRecognizer(swipeDownRecognizer)
            updateUI()
        }
    }
    func toogleEyes(byReactingTo tapRecognizer: UITapGestureRecognizer){
        if tapRecognizer.state == .ended{
            let eyes: FacialExpression.Eyes = (expression.eyes == .closed) ? .open : .closed
            expression = FacialExpression(eyes: eyes, mouth:expression.mouth)
        }
    }
    func increaseHappiness(){
        expression = expression.happier
    }
    func decreaseHappiness(){
        expression = expression.sadder
    }
    var expression = FacialExpression(eyes: .open,mouth: .grin){
        didSet{ // Property observers, if expression changes then execute some code
            updateUI()
        }
    }
    private func updateUI(){
        switch expression.eyes{
        case .open:
            faceView?.eyesOpen = true // Optional chaining if faceView is nil then do nothing
        case .closed:
            faceView?.eyesOpen = false
        case .squinting:
            faceView?.eyesOpen = false
        }
        faceView?.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0 // ?? defaulting if value is nil then use default value
    }
    private let mouthCurvatures = [FacialExpression.Mouth.grin: 0.5,.frown: -1.0,.smile:1.0,.neutral: 0.0,.smirk: -0.5]
}
