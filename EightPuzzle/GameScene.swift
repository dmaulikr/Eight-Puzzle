//
//  GameScene.swift
//  EightPuzzle
//
//  Created by Stu Schwartz on 5/31/15.
//  Copyright (c) 2015 Stu Schwartz. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var board:Board! = nil
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.board = Board(width: 3, height: 3)

        let gap = 4
        
        self.size = view.bounds.size
        
        let _tilesize = (self.size.width / CGFloat(self.board.width)) - CGFloat(gap)
        let tilesize = CGSize(width: _tilesize, height: _tilesize)
        
        
        
        for y in 0..<self.board.height {
            for x in 0..<self.board.width {
                let square = SKSpriteNode(color: SKColor.blackColor(), size: tilesize)
                
                square.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                
                println("x: \(x) y: \(y)")
                println("tilesize: \(tilesize)")
                println("size: \(view.bounds.size)")
                
                square.position = CGPoint(x: Int(tilesize.width/2) + Int(CGFloat(x)*tilesize.width) + gap, y: Int(tilesize.height/2) + Int(CGFloat(y)*tilesize.height) + gap)
                self.addChild(square)
                
                var label = SKLabelNode(fontNamed: "Arial")
                label.text = "\(y*self.board.width+x)"
                label.fontSize = 40
                label.position = square.position
                self.addChild(label)
                
            }
        }
        
        
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
