//
//  Solver.swift
//  EightPuzzle
//
//  Created by Stu Schwartz on 6/1/15.
//  Copyright (c) 2015 Stu Schwartz. All rights reserved.
//

import Foundation


class Solver {
    var board:Board! = nil

    init() {
        
    }
    
    init(board: Board!) {
        self.board = board
    }
    
    func solve() {
        if self.board == nil {
            println("nothing to solve")
            return
        }
        
        
        
        
    }
    
    func heuristic() {
        
    }
    
}