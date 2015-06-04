//
//  Solver.swift
//  EightPuzzle
//
//  Created by Stu Schwartz on 6/4/15.
//  Copyright (c) 2015 Stu Schwartz. All rights reserved.
//

import Foundation

class Solver {
    
    var initialState:[Int]!
    var currentState:[Int]!
    var goalState:[Int]!
    var width:Int!
    var height:Int!
    
    var queue:[StateNode]!
    var root:StateNode!
    
    init(initialState:[Int], goalState:[Int], width:Int, height:Int) {
        self.initialState = initialState
        self.currentState = initialState
        self.goalState = goalState
        self.width = width
        self.height = height
        
        self.root = StateNode(initialState)
        
    }
    
    func calculatePath() {
        while self.currentState != self.goalState {
            
        }
    }
    
    
}
