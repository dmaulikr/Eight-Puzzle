//: Playground - noun: a place where people can play

import Foundation



var a = [Int]()
a.append(5)
a.extend(1...10)
a[4] = 35
a
var b = a

b[5] = -1

a
b


for i in a {
    i
}





struct State : Equatable {
    var data:Array<Int>!
    var width:Int!
    var height:Int!
    
    init(width:Int, height:Int) {
        self.width = width
        self.height = height
        self.data = [Int](0..<((self.width*self.height)-1))
        self.data.append(-1)
    }
    
}

func ==(lhs:State, rhs:State) -> Bool {
    for i in 0..<lhs.data.count {
        if lhs.data[i] != rhs.data[i] {
            return false
        }
    }
    return true
}




class StateNode {
    var state:State!
    var depth:Int!
    var pathcost:Int!
    var parent:StateNode!
    var children:[StateNode]!
    
    init(state:State, depth:Int = 0, cost:Int = 0) {
        self.state = state
        self.depth = depth
        self.pathcost = cost
    }
}







class BoardSpace {
    var index:Int!
    var connections:[BoardSpace]!
    var occupied:Bool! = false
    var tile:Tile! = nil
    
    init(index:Int) {
        self.index = index
        self.connections = []
        
    }
    
    func addConnection(space: BoardSpace!) {
        self.connections.append(space)
        space.connections.append(self)
    }
    
}



class Tile {
    var value:Int!
    private var _currentSpace:BoardSpace!
    var destinationSpace:BoardSpace!
    
    var index:Int {
        get {
            return self.currentSpace.index
        }
    }
    
    var currentSpace:BoardSpace! {
        get {
            return self._currentSpace
        }
        
        set {
            if newValue == nil {
                self._currentSpace.occupied = false
                self._currentSpace.tile = nil
                self._currentSpace = newValue
                
            } else {
                self._currentSpace = newValue
                self._currentSpace.occupied = true
                self._currentSpace.tile = self
            }
            
            
        }
    }
    
    
    init(value: Int, space: BoardSpace) {
        self.value = value
        self.currentSpace = space
    }

    
    func moveTo(space: BoardSpace) {
        self.currentSpace = space
    }
    
    
}



class Board {
    var width: Int!
    var height: Int!
    
    var totalTiles: Int! {
        get {
            return (self.width * self.height) - 1
        }
    }
    
    var spaces: [BoardSpace]! = []
    var tiles: [Tile]! = []
    
    var history:[StateNode]! = []
    
    init(width:Int = 3, height:Int = 3) {
        self.width = width
        self.height = height
        
        for y in 0..<self.height {
            for x in 0..<self.width {
                
                var ts = BoardSpace(index: self.width*y+x)
                // connect to the node previous
                if x > 0 {
                    ts.addConnection(self.spaces[ts.index-1])
                }
                // connect to the node above
                if y > 0 {
                    ts.addConnection(self.spaces[ts.index-self.width])
                }
                self.spaces.append(ts)
            }
        }


        for i in 0...(self.totalTiles-1) {
            var t = Tile(value: i, space: self.spaces[i])
            self.tiles.append(t)
        }

    }


    func currentState() -> State {
        var currState:State = State(width:self.width, height:self.height)
        
        for (i,tilespace) in enumerate(self.spaces) {
            if tilespace.tile != nil {
                currState.data[i] = tilespace.tile.index
            } else {
                currState.data[i] = -1
            }
        }
        return currState
    }





}


class Solver {
    var initialState:State!
    var currentState:State!
    var goalState:State!
    
    var board:Board!
    
    var width:Int {
        get {
            return self.board.width
        }
    }
    var height:Int {
        get {
            return self.board.height
        }
    }
    
    
    var queue:[StateNode]!
    var root:StateNode!
    
    init(board:Board) {
        board.width
        self.board = board
        self.board
        self.initialState = self.board.currentState()
        self.currentState = self.board.currentState()
        self.initialState
        self.currentState
        self.goalState = State(width: self.width, height: self.height)
        
        self.queue = [StateNode]()
        self.root = StateNode(state: self.initialState, depth: 0, cost: 0)
    }
    
    func cost() -> Int {
        // manhattan cost function
        // get x,y values
        var thecost = 0
        for (i,currValue) in enumerate(self.currentState.data) {
            var val = currValue
            if currValue == -1 {
                val = self.currentState.data.count - 1
            }
            
            var goalX = i/self.width
            var goalY = i%self.width
            
            var currX = val/self.width
            var currY = val%self.width
            
            thecost += (abs(currX-goalX)+abs(currY-goalY))
            
        }
        return thecost
    }
    
    func calculatePath() {
        while self.currentState != self.goalState {
            
        }
    }
    
    
}



var brd:Board = Board(width: 3, height: 3)
brd
brd.width
brd.height
brd.totalTiles


var currState:State = State(width:3, height:3)

for (i,tilespace) in enumerate(brd.spaces) {
    i;
    
    if tilespace.tile != nil {
        currState.data[i] = tilespace.tile.index
    } else {
        currState.data[i] = -1
    }
}
currState

var s = Solver(board: brd)
s.currentState.data[0] = 2
s.currentState.data[1] = 1
s.currentState.data[2] = 0

s.currentState
s.cost()












