//
//  GameScene.swift
//  EightPuzzle
//
//  Created by Stu Schwartz on 5/31/15.
//  Copyright (c) 2015 Stu Schwartz. All rights reserved.
//

import SpriteKit

func randRange (lower: Int , upper: Int) -> Int {
    return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
}

class GameScene: SKScene {
    
    var width: Int! = 3
    var height: Int! = 3
    
    var totalTiles: Int! {
        get {
            return (self.width * self.height) - 1
        }
    }
    
    var gap = 1
    
    var graph: [TileSpace]! = []
    var tiles: [Tile]! = []
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.size = view.bounds.size
        
        let _tilesize = (self.size.width / CGFloat(self.width)) - CGFloat(gap)
        let tilesize = CGSize(width: _tilesize, height: _tilesize)
        
        
        
        for y in 0...(self.height-1) {
            for x in (0...self.width-1) {
                var position = CGPoint(x: Double(x)/Double(self.width)*Double(self.size.width) + Double(self.gap/2), y: Double(y)/Double(self.height)*Double(self.size.width) + Double((self.size.height-self.size.width)/2.0) + Double(self.gap/2))
                
                var ts = TileSpace(position:position, size:tilesize, index: self.width*y+x)
                // connect to the node previous
                if x > 0 {
                    ts.addConnection(self.graph[ts.index-1])
                }
                // connect to the node above
                if y > 0 {
                    ts.addConnection(self.graph[ts.index-self.width])
                }
                self.graph.append(ts)
                self.addChild(ts)
            }
        }
        
        
        
        for i in 0...(self.totalTiles-1) {
            var t = Tile(value: i, space: self.graph[i])
            self.tiles.append(t)
            self.addChild(t)
        }

        
        
    }
    
    
    func currentState() -> [Int] {
        let state = Array(map(self.tiles) {$0.currentState()} )
        return state
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        for tilespace:TileSpace in self.graph {
            if !tilespace.occupied {
                // get connected spaces to this tile and decide which one to move.
                var nconns = tilespace.connections.count
                var conn = tilespace.connections[randRange(0, nconns-1)]
                conn.tile.moveTo(tilespace)
                // test
                //self.tiles[0].moveTo(tilespace)
            }
        }
    }
}
