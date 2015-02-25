/*
* Copyright (C) 2015 47 Degrees, LLC http://47deg.com hello@47deg.com
*
* Licensed under the Apache License, Version 2.0 (the "License"); you may
* not use this file except in compliance with the License. You may obtain
* a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import UIKit
import SpriteKit

class GameViewController: UIViewController, FLGameSceneDelegate {
    
    @IBOutlet weak var viewOverlayCreating: UIView!
    @IBOutlet weak var viewOverlayPlaying: UIView!
    @IBOutlet weak var lblHint: UILabel!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnPlayPause: UIButton!
    
    lazy var scene: FLGameScene = FLGameScene(size: self.view.bounds.size)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = self.view as SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
        scene.gameDelegate = self
        
        setLocalizableTexts()
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
    
    // MARK: - UI texts
    
    func setLocalizableTexts() {
        lblHint.text = NSLocalizedString("game_overlay_view_creating_label_hint", comment: "")
        btnStart.setTitle(NSLocalizedString("game_overlay_view_creating_button_start", comment: ""), forState: .Normal)
        btnPlayPause.setTitle(NSLocalizedString("game_overlay_view_playing_button_pause", comment: ""), forState: .Normal)
    }
    
    // MARK: - FLGameSceneDelegate protocol implementation
    
    func gameDidChangeGameState(state: FLGameState) {
        switch state {
        case .Creating:
            viewOverlayCreating.hidden = false
            viewOverlayPlaying.hidden = true
        default:
            viewOverlayCreating.hidden = true
            viewOverlayPlaying.hidden = false
        }
    }
    
    // MARK: - Button handling
    
    @IBAction func didTapOnButtonStart() {
        scene.gameState = .Living
    }
    
    @IBAction func didTapOnButtonPlayPause() {
        switch scene.gameState {
        case .Living:
            scene.gameState = .Pause
            btnPlayPause.setTitle(NSLocalizedString("game_overlay_view_playing_button_play", comment: ""), forState: .Normal)
        case .Pause:
            scene.gameState = .Living
            btnPlayPause.setTitle(NSLocalizedString("game_overlay_view_playing_button_pause", comment: ""), forState: .Normal)
        default:
            break
        }
    }
    
}
