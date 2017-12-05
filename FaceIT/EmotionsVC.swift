//
//  EmotionsVCViewController.swift
//  FaceIT
//
//  Created by Ulan Assanov on 11/27/17.
//  Copyright © 2017 Ulan Assanov. All rights reserved.
//

import UIKit

class EmotionsVC: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationVC =  segue.destination
        if let navigationController = destinationVC as? UINavigationController{
            destinationVC = navigationController.visibleViewController ?? destinationVC
        }
        if let faceVC = destinationVC as? FaceVC ,
            let identifier = segue.identifier,
            let expression = emotionalFaces[identifier]{
                faceVC.expression = expression
                faceVC.navigationItem.title = (sender as? UIButton)?.currentTitle
        }
    }
    private let emotionalFaces: Dictionary<String,FacialExpression> = [
        "sad" : FacialExpression(eyes: .closed, mouth: .frown),
        "happy" : FacialExpression(eyes: .open,mouth: .smile),
        "worried" : FacialExpression(eyes: .open, mouth : .smirk)
    ]
}
