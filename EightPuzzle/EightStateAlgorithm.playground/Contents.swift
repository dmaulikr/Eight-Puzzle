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



srand(5)
for i in 0...100 {
    var v = Double(rand())/Double(Int32.max)
    if i == 0 {
        v = 0
    }
    if i == 100 {
        v = 1
    }
    v
}

Int32.max

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
    
    func asString() -> String {
        var strJoin = "".join(map(self.data) { String($0) })
        let strRepl = strJoin.stringByReplacingOccurrencesOfString("-1", withString: "_", options: NSStringCompareOptions.LiteralSearch, range: nil)
        return strRepl
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

extension Array {
    mutating func shuffle() {
        for i in 0..<(count - 1) {
            let j = Int(Double(rand())/Double(Int32.max)*Double(count - i)) + i
            swap(&self[i], &self[j])
        }
    }
}

Int(Double(rand())/Double(Int32.max)*6)


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
    
    func expand() {
        
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
    
    var initialState:State!
    var goalState:State!
    
    var queue:[StateNode]!
    var root:StateNode!
    var visited = Dictionary<String,StateNode>()
    
    
    init(width:Int = 3, height:Int = 3, state:State) {
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

        self.initialState = state
        self.goalState = State(width: self.width, height: self.height)

        for (baseIndex,value) in enumerate(self.initialState.data) {
            value
            baseIndex
            var t = Tile(value: value, space: self.spaces[baseIndex])
            self.tiles.append(t)
        }
        
        self.queue = [StateNode]()
        self.root = StateNode(state: self.initialState, depth: 0, cost: 0)
        self.queue.append(self.root)
        

    }


    func currentState() -> State {
        var currState:State = State(width:self.width, height:self.height)
        
        for (i,tilespace) in enumerate(self.spaces) {
            if tilespace.tile != nil {
                currState.data[i] = tilespace.tile.value
            } else {
                currState.data[i] = -1
            }
        }
        return currState
    }

    func stateAfterMove(tile:Tile!) -> State {
        var tileIndex = tile.currentSpace.index
        //var goToIndex:Int = nil
        
        var projState:State = self.currentState()
        
        for (i,tilespace) in enumerate(self.spaces) {
            if tilespace.tile == nil {
                var tmp = projState.data[i]
                projState.data[i] = projState.data[tileIndex]
                projState.data[tileIndex] = tmp
            }
        }
        
        return projState
    }
    
    func cost(state:State) -> Int {
        // manhattan cost function
        // get x,y values
        var thecost = 0
        for (i,currValue) in enumerate(state.data) {
            var val = currValue
            if currValue == -1 {
                val = state.data.count - 1
            }
            
            var goalX = i/self.width
            var goalY = i%self.width
            
            var currX = val/self.width
            var currY = val%self.width
            
            thecost += (abs(currX-goalX)+abs(currY-goalY))
            
        }
        return thecost
    }
    
    func expandNode(node:StateNode) {
        node.expand()
        for child in node.children {
            
            if let key = self.visited[child.state.asString()] {
                println("skipping")
            } else {
                self.queue.append(child)
            }
        }
    }
    
    func calculatePath() {
        while (self.currentState() != self.goalState) {
            if (self.queue.count == 0) {
                println("could not find path")
                break
            }
            
            self.step()
            
        }
    }
    
    func step() {
        // pop lowest cost state from list
        
    }
    
    
/*
    func currentMoves() -> [State] {
    
        for space in self.spaces {
            if space.tile == nil {
                for neighbor in space.connections {
                    var
                }
            }
        }

    }
*/

}




/*
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
    var visited = Dictionary<String,StateNode>()
    
    init(board:Board) {
        self.board = board
        self.board
        self.initialState = self.board.currentState()
        self.currentState = self.board.currentState()
        self.initialState
        self.currentState
        self.goalState = State(width: self.width, height: self.height)
        
        self.queue = [StateNode]()
        self.root = StateNode(state: self.initialState, depth: 0, cost: 0)
        self.queue.append(self.root)
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
        while (self.currentState != self.goalState) {
            if (self.queue.count == 0) {
                println("could not find path")
                break
            }
            
            
            
        }
    }
    
    func step() {
        
    }
    /*
    func expandNode(node:StateNode) {
        node.expand()
        for child in node.children {
            
            if self.visited.count(child.state.asString()) > 0 {
                println("skipping")
            } else {
                self.queue.append(child)
            }
        }
    }
    */
    
}
*/

var initialState = State(width: 3, height: 3)
initialState.data.shuffle()

var brd:Board = Board(width: 3, height: 3, state: initialState )
brd
brd.width
brd.height
brd.totalTiles
brd.initialState
brd.currentState().asString()


for space in brd.spaces {
    space.tile.index
}

for tile in brd.tiles {
    tile.value
    tile.currentSpace.index
}




