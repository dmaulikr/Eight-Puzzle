//
//  Board.swift
//  EightPuzzle
//
//  Created by Stu Schwartz on 5/31/15.
//  Copyright (c) 2015 Stu Schwartz. All rights reserved.
//

import Foundation

class Board {
    
    var width: Int! = 3
    var height: Int! = 3
    var totalTiles: Int! {
        get {
            return (self.width * self.height) - 1
        }
    }
    
    var _board: [TileSpace]!
    
    
    
    
    init() {
        
    }
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        self.initBoard()
    }
    
    func initBoard() {
        for j in [0...self.height] {
            for i in [0...self.width] {
                self._board.append(TileSpace())
            }
        }
    }
    
    
    
    
}