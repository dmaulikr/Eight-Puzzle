//
//  StateNode.swift
//  EightPuzzle
//
//  Created by Stu Schwartz on 6/3/15.
//  Copyright (c) 2015 Stu Schwartz. All rights reserved.
//

import Foundation


class StateNode {
    var state:[Int]! = []
    var depth:Int!
    var pathcost:Int!
    var parent:StateNode!
    var children:[StateNode]!
    

}