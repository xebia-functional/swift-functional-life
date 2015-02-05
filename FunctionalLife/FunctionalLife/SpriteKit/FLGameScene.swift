//
//  FLGameScene.swift
//  FunctionalLife
//
//  Created by Javier on 01/02/15.
//  Copyright (c) 2015 47 Degrees. All rights reserved.
//

import SpriteKit

class FLGameScene: SKScene {
    let kCellSize : CGFloat = CGFloat(32.0)
    
    var aliveCells = Array<CGPoint>()
    var cellNodes = Array<SKSpriteNode>()
    
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
        drawCellInCoordinates(CGPoint(x: 1, y: 1))
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
    
    // MARK: - Coordinate system
    
    func gameCoordinatesForSceneCoordinates(coordinates: CGPoint) -> CGPoint {
        return CGPoint(x: coordinates.x / kCellSize, y: coordinates.y / kCellSize)
    }
    
    func sceneCoordinatesForGameCoordinates(coordinates: CGPoint) -> CGPoint {
        return CGPoint(x: coordinates.x * kCellSize + (kCellSize / 2), y: coordinates.y * kCellSize + (kCellSize / 2))
    }
    
    // MARK: - Cell handling, drawing, adding and removing
    
    func addLivingCellToCoordinates(coordinates: CGPoint) -> Bool {
        // Check if cell is currently alive, if not, we just add it to our array of living cells
        let searchResult = self.aliveCells.filter({$0 == coordinates})
        if(searchResult.count == 0) {
            self.aliveCells.append(coordinates)
            return true
        }
        return false
    }
    
    func drawCellInCoordinates(coordinates: CGPoint) -> Void {
        if(self.addLivingCellToCoordinates(coordinates)) {
            // If we've added successfully a new cell to our list of cells, we should proceed to draw it:
            let cellNode = SKSpriteNode(texture: cellTexture, color: nil, size: CGSizeMake(kCellSize, kCellSize))
            cellNode.position = sceneCoordinatesForGameCoordinates(coordinates)
            addChild(cellNode)
        }
    }
    
    
}
