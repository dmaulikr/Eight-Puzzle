//
//  Tile.swift
//  EightPuzzle
//
//  Created by Stu Schwartz on 5/31/15.
//  Copyright (c) 2015 Stu Schwartz. All rights reserved.
//

import Foundation


class Tile {
    var value:Int!
    var board:Board
    var currentSpace:TileSpace!
    var destinationSpace:TileSpace! = nil
    
    var x:Int {
        get {
            return self.currentSpace.x
        }
    }
    
    var y:Int {
        get {
            return self.currentSpace.y
        }
    }
    
    var index:Int {
        get {
            return self.currentSpace.index
        }
    }
    
    var isMoving:Bool = false

    
    init(value: Int, board: Board, space: TileSpace) {
        self.value = value
        self.board = board
        self.currentSpace = space
    }
    
    func currentState() -> Int {
        return self.index
    }
    
}