//
//  FLGameScene.swift
//  FunctionalLife
//
//  Created by Javier on 01/02/15.
//  Copyright (c) 2015 47 Degrees. All rights reserved.
//

import SpriteKit

class FLGameScene: SKScene {
    let kCellSize: CGFloat = CGFloat(32.0)
    
    var aliveCells = Array<FLCell>()
    var zombifiedCells = Array<FLCell>() // Just a cool name for deuqueableCells
    
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
        addLivingCellToCoordinates(CGPoint(x: 1, y: 1))
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        let touch: AnyObject? = touches.anyObject()
        if let specificTouch: AnyObject = touch {
            let location = specificTouch.locationInNode(self)
            self.didTouchInView(specificTouch.locationInNode(self))
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    // MARK: - Coordinate system
    
    func gameCoordinatesForSceneCoordinates(coordinates: CGPoint) -> CGPoint {
        return CGPoint(x: floor(coordinates.x / kCellSize), y: floor(coordinates.y / kCellSize))
    }
    
    func sceneCoordinatesForGameCoordinates(coordinates: CGPoint) -> CGPoint {
        return CGPoint(x: coordinates.x * kCellSize + (kCellSize / 2), y: coordinates.y * kCellSize + (kCellSize / 2))
    }
    
    // MARK: - Cell handling, drawing, adding and removing
    
    func doesLiveACellInCoordinates(coordinates: CGPoint) -> Bool {
        return aliveCells.filter({c in c.coordinates.x == coordinates.x && c.coordinates.y == coordinates.y}).count > 0
    }
    
    func dequeueCell() -> FLCell? {
        let cellToBeDequeued = zombifiedCells.first
        if let cell = cellToBeDequeued {
            zombifiedCells.removeAtIndex(find(zombifiedCells, cell)!)
            return cell
        }
        return nil
    }
    
    func enqueueCell(cell: FLCell) {
        zombifiedCells.append(cell)
        if let index = find(aliveCells, cell) {
            aliveCells.removeAtIndex(index)
            cell.node.removeFromParent()
        }
    }
    
    func addLivingCellToCoordinates(coordinates: CGPoint) -> Bool {
        // Check if cell is currently alive, if not, we just add it to our array of living cells
        let isCellAlive = doesLiveACellInCoordinates(coordinates)
        if !isCellAlive {
            if let resurrectedCell = dequeueCell() {
                resurrectedCell.coordinates = coordinates
                resurrectedCell.node.position = sceneCoordinatesForGameCoordinates(coordinates)
                aliveCells.append(resurrectedCell)
                addChild(resurrectedCell.node)
            } else {
                aliveCells.append(FLCell(coordinates: coordinates,
                    node: drawCellInCoordinates(coordinates)))
            }
            return true
        }
        return false
    }
    
    func drawCellInCoordinates(coordinates: CGPoint) -> SKSpriteNode {
        let cellNode = SKSpriteNode(texture: cellTexture, color: nil, size: CGSizeMake(kCellSize, kCellSize))
        cellNode.position = sceneCoordinatesForGameCoordinates(coordinates)
        addChild(cellNode)
        return cellNode
    }
    
    func removeCellInCoordinates(coordinates: CGPoint) {
        let result = aliveCells.filter({c in c.coordinates.x == coordinates.x
                                        && c.coordinates.y == coordinates.y})
        if result.count > 0 {
            if let index = find(aliveCells, result.first!) {
                enqueueCell(aliveCells[index])
            }
        }
    }
    
    // MARK: - Drawing list of coordinates
    
    func drawListOfCells(coordinates: Array<CGPoint>) {
        // We'll go through a list of coordinates and draw each one of the cells of it...
        cleanListOfCells()
        for coordinate in coordinates {
            addLivingCellToCoordinates(coordinate)
        }
    }
    
    func cleanListOfCells() {
        var cellsToBeEnqueued = Array<FLCell>()
        cellsToBeEnqueued += aliveCells
        for cell in cellsToBeEnqueued {
            enqueueCell(cell)
        }
    }
    
    // MARK: - Responding to touches
    
    func didTouchInView(skCoordinates: CGPoint) -> Void {
        if let skView = self.view {
            //let skCoordinates = skView.convertPoint(uiKitCoordinates, toScene: self)
            let cellCoordinates = gameCoordinatesForSceneCoordinates(skCoordinates)
            if !addLivingCellToCoordinates(cellCoordinates) {
                removeCellInCoordinates(cellCoordinates)
            }
        }
    }
}
