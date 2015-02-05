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
    
    lazy var pinchGestureRecognizer : UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: Selector("didPinchOnView:"));
    var originalBounds : CGRect?
    let minimumZoom : CGFloat = 1.0 / 8.0
    let maximumZoom : CGFloat = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originalBounds = self.view.bounds
        
        let skView = self.view as SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        let scene : FLGameScene = FLGameScene(size: view.bounds.size)
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .ResizeFill
        
        skView.presentScene(scene)
        skView.addGestureRecognizer(pinchGestureRecognizer)
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
    
    // MARK: - Zoom in/out gesture recognizer
    
    func didPinchOnView(gestureRecognizer : UIPinchGestureRecognizer) {
        println("Pinch!! Scale: \(gestureRecognizer.scale)")
        let skView = self.view as SKView
        switch(originalBounds, skView.scene) {
        case let(.Some(bounds), .Some(scene)) :
            let scaledWidth = scene.size.width * gestureRecognizer.scale
            let scaledHeight = scene.size.height * gestureRecognizer.scale
            
            let scaleRatio = bounds.size.width / scaledWidth
            if(scaleRatio > minimumZoom && scaleRatio <= maximumZoom) {
                scene.size = CGSize(width: scaledWidth, height: scaledHeight)
            }
        default:
        break
        }
    }
}
