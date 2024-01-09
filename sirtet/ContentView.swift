//
//  ContentView.swift
//  sirtet
//
//  Created by Graham Louis on 1/2/24.
//

import SwiftUI
import Foundation

struct Block: View {
    var color = Color.gray
    var placed = false
    
    
    var body: some View {
//        RoundedRectangle(cornerRadius: 2)
//            .frame(width: 20, height: 20)
//            .overlay(RoundedRectangle(cornerRadius: 2).stroke(lineWidth: 1).foregroundColor(.gray).opacity(0.5))
//            
//        Rectangle().frame(width: 20, height: 20)
        Color.clear.frame(width: 20, height: 20).overlay {
            RoundedRectangle(cornerRadius: 2).frame(width: 25, height: 25)
                .overlay(RoundedRectangle(cornerRadius: 2).stroke(lineWidth: 1).foregroundColor(.gray).opacity(0.5))
        }

    }
}

struct Board: View {
    var boardGrid = myApp.Board()
    @State var paused = false
    @State var timer1 = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: true) { Timer in
        
    }
    
    func killTimer() -> Bool{
        return paused
    }

    func animationTimer(speed: Double){
            timer1 = Timer.scheduledTimer(withTimeInterval: speed, repeats: true) { Timer in
                
               
            }
        

         Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) { Timer in
            boardGrid.redrawBoard()
            updateBoard()
        }
    }
       
       // Define a 2D array of colors
   @State private var colorGrid: [[Color]] = Array(repeating: Array(repeating: .clear, count: 10), count: 20)

    
    
    func updateBoard(){
        for row in 0..<20{
            for column in 0..<10{
                if (boardGrid.get(row: row, column: column) == 0){
                    colorGrid[row][column] = .clear
                }
                else {
                    switch boardGrid.boardGrid[row][column][1]{
                    case 1:
                        colorGrid[row][column] = Color.indigo
                    case 2:
                        colorGrid[row][column] = Color.teal
                    case 3:
                        colorGrid[row][column] = Color.yellow
                    case 4:
                        colorGrid[row][column] = Color.green
                    case 5:
                        colorGrid[row][column] = Color.red
                    case 6:
                        colorGrid[row][column] = Color.orange
                    case 7:
                        colorGrid[row][column] = Color.blue
                    default:
                        colorGrid[row][column] = .black
                    }
                    
                }
            }
        }
    }
    
    func resetReference(){
        boardGrid.resetReference()
    }
    
    func offsetPieceRight(offset: Int){
        boardGrid.offsetRight(offset: offset)
    }
    
    func offsetPieceLeft(offset: Int){
        boardGrid.offsetLeft(offset: offset)
    }
    
    func translateRight() {
        boardGrid.translateRight()
    }
    
    func translateLeft() {
        boardGrid.translateLeft()
    }
    
    func rotateCW(){
        boardGrid.rotateCW()
    }
    
    func rotateCCW(){
        boardGrid.rotateCCW()
    }
    
    func getBlockedOut() -> Bool{
        return boardGrid.getBlockedOut()
    }
    
    func autoDown() {
        boardGrid.autoDown()
    }
    
    func holdPiece() {
        boardGrid.holdPiece()
    }
    
    func getScore() -> Int{
        return boardGrid.score
    }
    
    func getLevel() -> Int{
        return boardGrid.currentLevel
    }
    
    func getHeldPiece() -> Piece{
        return boardGrid.heldPiece
    }
    
    func getColor(piece: Piece)-> Color{
        if (piece.color == 0){
            return .clear
        }
        else {
            switch piece.color{
            case 1:
                return Color.indigo
            case 2:
                return Color.teal
            case 3:
                return Color.yellow
            case 4:
                return Color.green
            case 5:
                return Color.red
            case 6:
                return Color.orange
            case 7:
                return Color.blue
            default:
                return .black
            }
            
        }
    }
    
    @State var i = 0
    var body: some View {
        VStack {
            Text("Held:")
            ForEach(i..<boardGrid.heldPiece.shape.count, id: \.self) { row in
                HStack {
                    ForEach(0..<boardGrid.heldPiece.shape[0].count, id: \.self) { column in
                        if(boardGrid.heldPiece.shape[row][column] == 1){
                            Block().foregroundColor(getColor(piece: boardGrid.heldPiece))
                        }
                        else{
                            Block().foregroundColor(Color(UIColor.systemBackground))
                        }
                    }
                }
            }
//            .scaleEffect(0.5)
            Spacer()
            ForEach(0..<20, id: \.self) { row in
                HStack {
                    ForEach(0..<10, id: \.self) { column in
                        Block().foregroundColor(colorGrid[row][column])
                    }
                }
            }
        }
        .onAppear(perform: {
            animationTimer(speed: boardGrid.speed)
        })
    }
    
    
}


struct ContentView: View {
    @State var board = Board()
    @State var gameOver = false
    @State var gameScore = 0
    @State var currentLevel = 1
    @State var previousScore = 0
    @State var progressTowardMove = 0.0
    @State var oldLocation = CGPoint.zero
    @State var currentLocation = CGPoint.zero
    @State private var timer: Timer? = nil
    
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: board.boardGrid.speed, repeats: true) { _ in
            board.boardGrid.update()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    
    func checkGameOver(){
        if (gameOver == false){
            gameOver = board.getBlockedOut()
        }
        else {
            if (gameScore != 0){
                previousScore = gameScore
            }
            board = Board()
        }
    }
    
    func getScore(){
        gameScore = board.getScore()
    }
    
    func getLevel(){
        currentLevel = board.getLevel()
    }
    
    
    var body: some View {
        if gameOver {
            Text("Tetris").font(.largeTitle).bold().frame(width: 350,height: 100, alignment: .center).foregroundColor(.blue)
            Text("Score: \(previousScore)")
            Spacer()
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .foregroundColor(.red)
                .overlay {
                Text("New Game").font(.title).foregroundColor(.white)
                }
                .frame(width: 200, height: 100)
                .onTapGesture {
                    gameOver = false
                }
            Spacer()
        }
        else{
            ZStack{
                let dragGesture = DragGesture()
                    .onChanged { value in
                        let location = value.location
                        var dx = location.x - oldLocation.x
                        var dy = location.y - oldLocation.y
                        
                        if (currentLocation.x == 0.0 ){
                            oldLocation = value.location
                            currentLocation = value.location
                        }
                        else {
                            currentLocation = value.location
                        }
                        
                        progressTowardMove += (location.x - oldLocation.x)

                        oldLocation = location
                        
                            if (progressTowardMove > 20){
                                board.translateRight()
                                progressTowardMove = 0
                            }
                            
                            if (progressTowardMove < -20){
                                board.translateLeft()
                                progressTowardMove = 0
                            }
                        
                        if (value.translation.width.magnitude < 25){
                            if (value.translation.height > 100){
                                board.autoDown()
                            }
                        }
                            
                            if (value.translation.height < -100){
                                board.holdPiece()
                            }
                        
                        
                        
                    }
                    .onEnded { _ in
                        oldLocation.x = 0.0
                        currentLocation.x = 0.0
                        
                        progressTowardMove = 0
                        board.resetReference()
                    }
                    
                HStack{
                    Group{
                        Rectangle().foregroundColor(Color(UIColor.systemBackground)).onTapGesture {
                            board.rotateCCW()
                        }
                        Rectangle().foregroundColor(Color(UIColor.systemBackground)).onTapGesture {
                            board.rotateCW()
                        }.frame(height: 530)
                    }
                    
                }.gesture(dragGesture)
                
                VStack{
                    HStack{
                        Button("Restart") {
                            board.boardGrid.restart()
                            stopTimer()
                            
                        }.padding(.horizontal)
                        Spacer()
                        Button {
                            if (!(timer?.isValid ?? false)){
                                startTimer()
                                board.paused = false
                            }
                            else {
                                stopTimer()
                                board.paused = true
                            }
                        } label: {
                            Circle().foregroundColor(.blue).frame(width: 50,height: 50)
                                .overlay {
                                Image(systemName: "pause.fill").foregroundColor(.black)
                            }
                        }.padding(.horizontal)

                        
                    }
                    board.onAppear(perform: {
                        startTimer()
                        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                            checkGameOver()
                            getScore()
                            getLevel()
                        }
                    })
                    
                    
                    HStack{
                        VStack{
                            
                            Text("Score: \(gameScore)").padding(.horizontal)
                            Text("Level: \(currentLevel)")
                            
                        }
                    }
                    .onChange(of: currentLevel) { oldValue, newValue in
                        stopTimer()
                        startTimer()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
