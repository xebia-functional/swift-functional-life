//
//  FLGameScene.swift
//  FunctionalLife
//
//  Created by Javier on 01/02/15.
//  Copyright (c) 2015 47 Degrees. All rights reserved.
//

import SpriteKit

class FLGameScene: SKScene {
    
    let kCellSize : CGFloat = 32.0
    
    lazy var cellTexture : SKTexture = {
        // It's been pointed in some sites that SKShapeNode is not a trustworthy enough to draw shapes in our scene yet, so we're going to generate our cell shape with QuartzCore at initializatiom:
        
        func createTexture() -> SKTexture {
            let kPadding : CGFloat = 1.0
            let kCornerRadius : CGFloat = 4.0
            let kSize : CGFloat = 32.0
            
            UIGraphicsBeginImageContext(CGSize(width: kSize, height: kSize))
            let ctx = UIGraphicsGetCurrentContext()
            mainGreenColor.setFill()
            
            let rect = CGRectMake(kPadding, kPadding, CGFloat(kSize - (kPadding * 2)), CGFloat(kSize - (kPadding * 2)))
            let path = UIBezierPath(roundedRect: rect, cornerRadius: kCornerRadius)
            CGContextAddPath(ctx, path.CGPath)
            CGContextFillPath(ctx)
            
            let textureImage = UIGraphicsGetImageFromCurrentImageContext() as UIImage
            return SKTexture(image: textureImage)
        }
        
        return createTexture()        
    }()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.backgroundColor = accentGreenColor
        
        let cellNode = SKSpriteNode(texture: cellTexture, color: SKColor.redColor(), size: CGSizeMake(kCellSize, kCellSize))
        cellNode.position = CGPoint(x: 0, y: 0)
        addChild(cellNode)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            /*let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)*/
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
}
