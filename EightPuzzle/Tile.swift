//
//  Tile.swift
//  EightPuzzle
//
//  Created by Stu Schwartz on 5/31/15.
//  Copyright (c) 2015 Stu Schwartz. All rights reserved.
//

import Foundation
import SpriteKit

class Tile : SKNode {
    var value:Int!
    var currentSpace:TileSpace!
    var destinationSpace:TileSpace!

    var index:Int {
        get {
            return self.currentSpace.index
        }
    }
    
    var isMoving:Bool = false
    
    
    init(value: Int, space: TileSpace) {
        super.init()
    
        self.value = value
        self.currentSpace = space
        self.currentSpace.occupied = true
        self.currentSpace.tile = self
        
        self.position = self.currentSpace.position
        
        let square = CGRect(x: 0, y: 0, width: self.currentSpace.size.width, height: self.currentSpace.size.height)
        let shape:SKShapeNode = SKShapeNode(rect: square)
        shape.fillColor = SKColor.blueColor()
        
        self.addChild(shape)
        
        let label = SKLabelNode(text: "\(value)")
        
        label.fontColor = SKColor.whiteColor()
        label.fontSize = 40
        label.position = CGPoint(x: square.width/2.0, y: (square.height/2.0)-(label.fontSize/2.0))
        
        self.addChild(label)
    }


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        
    }
    
    func currentState() -> Int {
        return self.index
    }
    
    func moveTo(space: TileSpace) {
        space.occupied = true
        self.destinationSpace = space
        
        var action = SKAction.moveTo(self.destinationSpace.position, duration: 0.1)
        self.runAction(action, completion: self.completedMove)
    }
    
    func completedMove() {
        // old space
        self.currentSpace.occupied = false
        self.currentSpace.tile = nil
        
        // new space
        self.currentSpace = self.destinationSpace
        self.currentSpace.tile = self
        self.currentSpace.occupied = true
        
    }
    
}