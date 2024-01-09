//
//  sirtetApp.swift
//  sirtet
//
//  Created by Graham Louis on 1/2/24.
//

import SwiftUI


struct myApp{
    class Board {
        var boardGrid: [[[Int]]] = Array(repeating: Array(repeating: Array(repeating: 0, count: 2), count: 10), count: 20)
        public var activePiece: Piece = Piece()
        public var heldPiece: Piece = Piece()
        var blockedOut = false
        var heldDuringTurn = false
        var currentLevel = 1
        var speed = 0.8
        var linesCleared = 0
        var score = 0
        var pieceBag: [Int] = []
        var ghostPiece = Piece()
        
        
        
        func getBlockedOut() -> Bool {
            return blockedOut
        }
        
        func get(row: Int) -> [Int] {
            return boardGrid[row][0]
        }
        
        func get(row: Int, column: Int) -> Int {
            return boardGrid[row][column][0]
        }
        

        func dropPiece(piece: Piece){
            activePiece = piece
            
        }
        
        func checkForHorizontalCollision() -> Bool {
            if (activePiece.shape == [[0]]){return true}
            for row in 0..<activePiece.shape.count{
                for col in 0..<activePiece.shape[0].count{
                    if (activePiece.anchor[1] + col + 1 > 10 && activePiece.shape[row][col] == 1 || activePiece.anchor[1] + col < 0 && activePiece.shape[row][col] == 1){
                        return true
                    }
                    if (activePiece.shape[row][col] == 1 && boardGrid[activePiece.anchor[0] + row][activePiece.anchor[1] + col][0] == 2){
                        return true
                    }
                    if ( activePiece.shape[row][col] == 1 && boardGrid[activePiece.anchor[0] + row][activePiece.anchor[1] + col][0] == 2){
                        return true
                    }
                }
            }
            
            return false
        }
        
        func resetReference(){
            activePiece.previousPoint = activePiece.anchor[1]
        }
        
        func offsetRight(offset: Int){
            var dx = offset
            dx += activePiece.previousPoint - activePiece.anchor[1]
            if (dx != 0){
                translateRight()
            }
        }
        
        func offsetLeft(offset: Int){
            var dx = offset
            dx += activePiece.previousPoint - activePiece.anchor[1]
            if (dx != 0){
                translateLeft()
            }
        }
        
        
        func translateRight(){
            activePiece.anchor[1] += 1
            if(activePiece.shape != [[0]]){
                if (checkForHorizontalCollision()){
                    activePiece.anchor[1] -= 1
                }
            }
        }
        
        func translateLeft(){
            activePiece.anchor[1] -= 1
            if(activePiece.shape != [[0]]){
                if (checkForHorizontalCollision()){
                    activePiece.anchor[1] += 1
                }
            }
        }
        
       
        func rotateCCW(){
            
            if(activePiece.shape == [[0]]){return}
            
            if (activePiece.orientation > 1){ activePiece.orientation -= 1 }
            
            else { activePiece.orientation = 4 }
            
            activePiece.getShape()
            
            for row in 0..<activePiece.shape.count{
                for col in 0..<activePiece.shape[0].count{
                    if (activePiece.anchor[0] + row > 19){
                        activePiece.anchor[0] -= 1
                    }
                    else if (activePiece.anchor[1] + activePiece.shape[0].count > 10){
                        activePiece.anchor[1] -= 1
                    }
                    else if (activePiece.anchor[1] < 0){
                        activePiece.anchor[1] += 1
                    }
                    else if (activePiece.shape[row][col] == 1 && boardGrid[activePiece.anchor[0] + row][activePiece.anchor[1] + col][0] == 2){
                        activePiece.anchor[1] -= 1
                    }
                    else if (activePiece.shape[row][col] == 1 && boardGrid[activePiece.anchor[0] + row][activePiece.anchor[1] + col][0] == 2){
                        activePiece.anchor[1] += 1
                    }
                    else if (activePiece.shape[row][col] == 1 && boardGrid[activePiece.anchor[0] + row][activePiece.anchor[1] + col][0] == 2){
                        activePiece.anchor[0] -= 1
                    }
                }
            }
        }
        
        func rotateCW(){
            if (activePiece.orientation < 4){ activePiece.orientation += 1 }
            
            else { activePiece.orientation = 1 }
            
            activePiece.getShape()
            
            for row in 0..<activePiece.shape.count{
                for col in 0..<activePiece.shape[0].count{
                    if (activePiece.anchor[0] + row > 19){
                        activePiece.anchor[0] -= 1
                    }
                    else if (activePiece.anchor[1] + activePiece.shape[0].count > 10){
                        activePiece.anchor[1] -= 1
                    }
                    else if (activePiece.anchor[1] < 0){
                        activePiece.anchor[1] += 1
                    }
                    else if (activePiece.shape[row][col] == 1 && boardGrid[activePiece.anchor[0] + row][activePiece.anchor[1] + col][0] == 2){
                        activePiece.anchor[1] -= 1
                    }
                    else if (activePiece.shape[row][col] == 1 && boardGrid[activePiece.anchor[0] + row][activePiece.anchor[1] + col][0] == 2){
                        activePiece.anchor[1] += 1
                    }
                    else if (activePiece.shape[row][col] == 1 && boardGrid[activePiece.anchor[0] + row][activePiece.anchor[1] + col][0] == 2){
                        activePiece.anchor[0] -= 1
                    }
                }
            }
        }
        
        func checkForCollision() -> Bool {
            for row in 0..<activePiece.shape.count{
                for col in 0..<activePiece.shape[0].count{
                    if (activePiece.anchor[0] + activePiece.shape.count >= 20 && activePiece.shape[row][col] == 1){
                        return true
                    }
                    if (activePiece.shape[row][col] == 1 && boardGrid[activePiece.anchor[0] + row + 1][activePiece.anchor[1] + col][0] == 2){
                        return true
                    }
                }
            }
            
            return false
        }
        
        func checkForGhostCollision() -> Bool {
            for row in 0..<ghostPiece.shape.count{
                for col in 0..<ghostPiece.shape[0].count{
                    if (ghostPiece.anchor[0] + ghostPiece.shape.count >= 20 && ghostPiece.shape[row][col] == 1){
                        return true
                    }
                    if (ghostPiece.shape[row][col] == 1 && boardGrid[ghostPiece.anchor[0] + row + 1][ghostPiece.anchor[1] + col][0] == 2){
                        return true
                    }
                }
            }
            
            return false
        }
        
        func redrawBoard() {
            
            ghostPiece.shape = Array(repeating: Array(repeating: 0, count: activePiece.shape[0].count), count: activePiece.shape.count)
            
            for row in 0..<activePiece.shape.count{
                for col in 0..<activePiece.shape[0].count{
                    if (activePiece.shape[row][col] == 1){
                        ghostPiece.shape[row][col] = 3
                    }
                }
            }
            
            for row in 0..<20{
                for column in 0..<10{
                    if(boardGrid[row][column][0] == 1 || boardGrid[row][column][0] == 3){
                        boardGrid[row][column][0] = 0
                        boardGrid[row][column][1] = 0
                    }
                }
            }
//            if (ghostPiece.shape != [[0]]){
//                projectGhostPiece()
//            }
            if (ghostPiece.shape[0].count == 4){
                ghostPiece.shape.remove(at: 2)
            }
            
            if (ghostPiece.shape != [[0]]){
                while (!checkForGhostCollision()){
                    ghostPiece.anchor[0] += 1
                }
            }
            
            ghostPiece.anchor[1] = activePiece.anchor[1]
            
            
            for row in 0..<activePiece.shape.count{
                for column in 0..<activePiece.shape[0].count{
                    if (activePiece.shape[row][column] == 0 ){continue}
                    var i = activePiece.anchor[0] + row
                    var j = activePiece.anchor[1] + column
                    boardGrid[i][j][0] = activePiece.shape[row][column]
                    boardGrid[i][j][1] = activePiece.color
                    
                    if (ghostPiece.shape[row][column] == 0 ){continue}
                    i = ghostPiece.anchor[0] + row
                    j = ghostPiece.anchor[1] + column
                    boardGrid[i][j][0] = ghostPiece.shape[row][column]
                    boardGrid[i][j][1] = ghostPiece.color
                    
                }
            }
            

        }
        
        func checkForClear() {
            var possibleClearedLine = 0
            var comboLines = 0;
            
            for row in 0..<20{
                for column in 0..<10{
                    if(boardGrid[row][column][0] == 2){
                        possibleClearedLine = row
                    }
                    else {
                        possibleClearedLine = 0
                        break;
                    }
                }
                if (possibleClearedLine != 0){
                    comboLines += 1
                    self.linesCleared += 1
                    if (linesCleared % 10 == 0){
                        currentLevel += 1
                        speed -= 0.08
                    }
                    
                        self.boardGrid.remove(at: row)
                        self.boardGrid.insert(Array(repeating: Array(repeating: 0, count: 2), count: 10), at: 0)
                    
                }
            }
            getNewScore(linesCleared: comboLines)
        }
        
        func getNewScore(linesCleared: Int){
            switch linesCleared{
            case 1:
                self.score += 100 * currentLevel
            case 2:
                self.score += 300 * currentLevel
            case 3:
                self.score += 500 * currentLevel
            case 4:
                self.score += 800 * currentLevel
            default:
                print("")
            }
            
        }
        
        func checkForBlockOut() {
            if(activePiece.anchor[0] == 0){
                 blockedOut = true
                 boardGrid = Array(repeating: Array(repeating: Array(repeating: 0, count: 2), count: 10), count: 20)
                speed = 0.8
                currentLevel = 1
            }
        }
        
        func restart(){
            blockedOut = true
            boardGrid = Array(repeating: Array(repeating: Array(repeating: 0, count: 2), count: 10), count: 20)
           speed = 0.8
           currentLevel = 1
            timer?.invalidate()
        }
        
        func autoDown() {
            while(!checkForCollision()){
                activePiece.fall()
            }
        }
        
        func holdPiece() {
            if (!heldDuringTurn){
                var tempPiece = heldPiece
                heldPiece = activePiece
                activePiece = tempPiece
                activePiece.anchor = [0,3]
                heldPiece.orientation = 1
                heldPiece.getShape()
                heldDuringTurn = true
            }
        }
        
                
        
        func update() {
            
            
            if (activePiece.shape == [[0]]){
                if (pieceBag == []){
                    pieceBag = [1,2,3,4,5,6,7]
                    pieceBag.shuffle()
                }
                let randomInt = pieceBag.removeLast()
                switch randomInt{
                case 1:
                    dropPiece(piece: Tpiece())
                case 2:
                    dropPiece(piece: Ipiece())
                case 3:
                    dropPiece(piece: Opiece())
                case 4:
                    dropPiece(piece: Spiece())
                case 5:
                    dropPiece(piece: Zpiece())
                case 6:
                    dropPiece(piece: Lpiece())
                case 7:
                    dropPiece(piece: Rpiece())
                default:
                    print("")
                }

                
                
            }
            else if (checkForCollision()){
                if (!(timer?.isValid ?? false)){
                    startPlaceTimer()
                }
                
            }
            else {
                redrawBoard()
                activePiece.fall()
            }
        }
        
        var timer: Timer? = nil
        
        func startPlaceTimer(){
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { Timer in
                self.activePiece.place()
                self.redrawBoard()
                self.checkForBlockOut()
                self.activePiece = Piece()
                self.checkForClear()
                self.heldDuringTurn = false
                self.timer?.invalidate()
            })
        }
        func stopPlaceTimer(){
            timer?.invalidate()
        }
    }
}
