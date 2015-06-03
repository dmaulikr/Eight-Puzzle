//
//  TileSpace.swift
//  EightPuzzle
//
//  Created by Stu Schwartz on 5/31/15.
//  Copyright (c) 2015 Stu Schwartz. All rights reserved.
//

import Foundation
import SpriteKit

class TileSpace : SKNode {
    var index:Int!
    var size:CGSize!
    var connections:[TileSpace]!
    
    init(position: CGPoint, size: CGSize, index:Int) {
        super.init()
        
        self.position = position
        self.size = size
        self.index = index
        
        self.connections = []
        
        
        let square = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let shape:SKShapeNode = SKShapeNode(rect: square)
        
        self.addChild(shape)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addConnection(space: TileSpace!) {
        self.connections.append(space)
        space.connections.append(self)
    }
    
}