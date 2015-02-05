//
//  GameViewController.swift
//  FunctionalLife
//
//  Created by Javier on 01/02/15.
//  Copyright (c) 2015 47 Degrees. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = self.view as SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        let scene : FLGameScene = FLGameScene(size: view.bounds.size)
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .ResizeFill
        
        skView.presentScene(scene)
        
        let tapGestureRecognizer : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "didTapOnGameView:")
        skView.addGestureRecognizer(tapGestureRecognizer)
    }

    override func shouldAutorotate() -> Bool {
        return false
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.LandscapeRight.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.LandscapeRight.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK - Tap gesture handling...
    
    func didTapOnGameView(tapGesture : UITapGestureRecognizer) {
        let skView = self.view as SKView
        if let scene = skView.scene {
            let flScene = scene as FLGameScene
            flScene.didTouchInView(tapGesture.locationInView(self.view))
        }
        
    }
}
