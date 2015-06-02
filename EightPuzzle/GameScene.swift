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
        
        let _tilesize = (view.bounds.size.width / CGFloat(self.board.width)) - CGFloat(gap)
        let tilesize = CGSize(width: _tilesize, height: _tilesize)
        
        
        
        for y in 0..<self.board.height {
            for x in 0..<self.board.width {
                let square = SKSpriteNode(color: SKColor.blackColor(), size: tilesize)
                square.position = CGPoint(x: Int(CGFloat(x)*tilesize.width) + (gap/2), y: Int(CGFloat(y)*tilesize.height) + (gap/2))
                self.addChild(square)
            }
        }
        
        
        
        
        
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(myLabel)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
