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
    
    var graph: [TileSpace]! = []
    var tiles: [Tile]! = []

    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        self.initGraph()
        self.populate()
    }
    
    func initGraph() {
        // create
        for y in 0...(self.height-1) {
            for x in (0...self.width-1) {
                var ts = TileSpace(x: x, y: y, index: self.width*y+x)
                if x > 0 {
                    ts.addConnection(self.graph[ts.index-1])
                }
                if y > 0 {
                    ts.addConnection(self.graph[ts.index-self.width])
                }
                self.graph.append(ts)
            }
        }
    }
    
    func populate() {
        for i in 0...(self.height-1) {
            self.tiles.append(Tile(value: i, board:self, space: self.graph[i]))
        }
    }
    
    func currentState() -> [Int] {
        let state = Array(map(self.tiles) {$0.currentState()} )
        return state
    }
    
    
    
    
}