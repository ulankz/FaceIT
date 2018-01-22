//
//  BlinkingFVC.swift
//  FaceIT
//
//  Created by Ulan Assanov on 1/22/18.
//  Copyright © 2018 Ulan Assanov. All rights reserved.
//

import UIKit

class BlinkingFVC: FaceVC {
    var blinking = false{
        didSet{
            blinkIfNeeded()
        }
    }
    private struct BlinkRate{
        static let closedDuration: TimeInterval = 0.4
        static let openDuration: TimeInterval = 2.5
    }
    private func blinkIfNeeded(){
        if blinking{
            faceView.eyesOpen = false
            Timer.scheduledTimer(withTimeInterval: BlinkRate.closedDuration, repeats: false) { [weak self] timer in
                self?.faceView.eyesOpen = true
                Timer.scheduledTimer(withTimeInterval: BlinkRate.openDuration, repeats: false) { [weak self] timer in
                    self?.blinkIfNeeded()
                }
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        blinking = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        blinking = false
    }
}
