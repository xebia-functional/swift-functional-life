//
//  FLCell.swift
//  FunctionalLife
//
//  Created by Javier de Silóniz Sandino on 05/02/15.
//  Copyright (c) 2015 47 Degrees. All rights reserved.
//

import UIKit
import SpriteKit

class FLCell: NSObject {
    
    var coordinates: CGPoint!
    let node: SKSpriteNode!
    
    init(coordinates: CGPoint, node: SKSpriteNode) {
        self.coordinates = coordinates
        self.node = node
    }
    
}