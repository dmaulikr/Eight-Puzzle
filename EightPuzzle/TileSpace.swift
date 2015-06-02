//
//  TileSpace.swift
//  EightPuzzle
//
//  Created by Stu Schwartz on 5/31/15.
//  Copyright (c) 2015 Stu Schwartz. All rights reserved.
//

import Foundation

class TileSpace {
    
    var x:Int!
    var y:Int!
    var index:Int!
    var connections:[TileSpace]!
    
    init(x: Int, y:Int, index:Int) {
        self.x = x
        self.y = y
        self.index = index
        
        self.connections = []
    }
    
    func addConnection(space: TileSpace!) {
        self.connections.append(space)
        space.connections.append(self)
    }
    
}