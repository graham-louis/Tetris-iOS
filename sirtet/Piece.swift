//
//  Piece.swift
//  sirtet
//
//  Created by Graham Louis on 1/5/24.
//

import Foundation

class Piece {
    var anchor = [0,3]
    var orientation = 1
    var shape: [[Int]] = [[0]]
    var color = 0
    var previousPoint = 3
    
    func fall() {
        anchor[0] += 1
    }
    
    func getShape(){
        
    }
    
    func place(){
        for row in 0..<shape.count{
            for column in 0..<shape[0].count{
                if shape[row][column] == 1{
                    shape[row][column] = 2
                }
            }
        }
    }
    
    
}

class Tpiece: Piece {
    override init() {
        super.init()
        shape = [[0,1,0],
                 [1,1,1]]
        color = 1
    }
    
    
    override func getShape(){
        switch orientation{
        case 1:
            shape = [[0,1,0],
                     [1,1,1]]
        case 2:
            shape = [[1,0],
                     [1,1],
                     [1,0]]
        case 3:
            shape = [[1,1,1],
                     [0,1,0]]
        case 4:
            shape = [[0,1],
                     [1,1],
                     [0,1]]
        default:
            shape = [[0]]
        }
    }
}

class Ipiece: Piece {
    override init() {
        super.init()
        shape = [[1,1,1,1]]
        color = 2
    }
    
    
    override func getShape(){
        switch orientation{
        case 1:
            shape = [[0,0,0,0],
                     [1,1,1,1],
                     [0,0,0,0]]
        case 2:
            
            shape = [[0,0,1,0],
                     [0,0,1,0],
                     [0,0,1,0],
                     [0,0,1,0]]
            
            
        case 3:
            
            shape =  [[0,0,0,0],
                      [0,0,0,0],
                      [1,1,1,1],
                      [0,0,0,0]]
        case 4:
            shape = [[0,1,0],
                     [0,1,0],
                     [0,1,0],
                     [0,1,0]]
        default:
            shape = [[0]]
        }
    }
}

class Opiece: Piece {
    override init() {
        super.init()
        shape = [[1,1],
                 [1,1]]
        color = 3
    }
    
    override func getShape(){
        switch orientation{
        case 1:
            shape = [[1,1],
                     [1,1]]
        case 2:
            shape = [[1,1],
                     [1,1]]
        case 3:
            shape = [[1,1],
                     [1,1]]
        case 4:
            shape = [[1,1],
                     [1,1]]
        default:
            shape = [[0]]
        }
    }
}

class Spiece: Piece {
    override init() {
        super.init()
        shape = [[0,1,1],
                 [1,1,0]]
        color = 4
    }
    
    override func getShape(){
        switch orientation{
        case 1:
            shape = [[0,1,1],
                     [1,1,0]]
        case 2:
            shape = [[1,0],
                     [1,1],
                     [0,1]]
        case 3:
            shape = [[0,1,1],
                     [1,1,0]]
        case 4:
            shape = [[1,0],
                     [1,1],
                     [0,1]]
        default:
            shape = [[0]]
        }
    }
}

class Zpiece: Piece {
    override init() {
        super.init()
        shape = [[1,1,0],
                 [0,1,1]]
        color = 5
    }
    
    override func getShape(){
        switch orientation{
        case 1:
            shape = [[1,1,0],
                     [0,1,1]]
        case 2:
            shape = [[0,1],
                     [1,1],
                     [1,0]]
        case 3:
            shape = [[1,1,0],
                     [0,1,1]]
        case 4:
            shape = [[0,1],
                     [1,1],
                     [1,0]]
        default:
            shape = [[0]]
        }
    }
}

class Lpiece: Piece {
    override init() {
        super.init()
        shape = [[0,0,1],
                 [1,1,1]]
        color = 6
    }
    
    override func getShape(){
        switch orientation{
        case 1:
            shape = [[0,0,1],
                     [1,1,1]]
        case 2:
            shape = [[1,0],
                     [1,0],
                     [1,1]]
        case 3:
            shape = [[1,1,1],
                     [1,0,0]]
        case 4:
            shape = [[1,1],
                     [0,1],
                     [0,1]]
        default:
            shape = [[0]]
        }
    }
}

class Rpiece: Piece {
    override init() {
        super.init()
        shape = [[1,0,0],
                 [1,1,1]]
        color = 7
    }
    
    override func getShape(){
        switch orientation{
        case 1:
            shape = [[1,0,0],
                     [1,1,1]]
        case 2:
            shape = [[1,1],
                     [1,0],
                     [1,0]]
        case 3:
            shape = [[1,1,1],
                     [0,0,1]]
        case 4:
            shape = [[0,1],
                     [0,1],
                     [1,1]]
        default:
            shape = [[0]]
        }
    }
}
