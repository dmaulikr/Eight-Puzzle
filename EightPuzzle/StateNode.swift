//
//  StateNode.swift
//  EightPuzzle
//
//  Created by Stu Schwartz on 6/3/15.
//  Copyright (c) 2015 Stu Schwartz. All rights reserved.
//

import Foundation

struct State {
    var data:[Int]!
    var width:Int!
    var height:Int!
    
    init(width:Int, height:Int, data:[Int]) {
        self.width = width
        self.height = height
        self.data = data
    }
}

class StateNode {
    var state:[Int]! = []
    var depth:Int!
    var pathcost:Int!
    var parent:StateNode!
    var children:[StateNode]!
    
    init(startState:State) {
        
    }
}


class BoardSpace {
    var index:Int!
    var connections:[TileSpace]!
    var occupied:Bool! = false
    var tile:Tile! = nil
    
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

