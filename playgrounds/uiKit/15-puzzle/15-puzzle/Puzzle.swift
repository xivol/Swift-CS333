//
//  Puzzle.swift
//  15-puzzle
//
//  Created by Илья Лошкарёв on 19.02.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import Foundation

protocol PuzzleDelegate: class { // weak delegates work only for class-bound protocols
    func puzzleDidSwitchTiles(puzzle: Puzzle, firstTilePos: (Int,Int), secondTilePos: (Int,Int))
    func puzzleIsSolved(puzzle: Puzzle)
}

class Puzzle {
    let size: Int
    var board: [[Int]]
    weak var delegate: PuzzleDelegate?  // break potensial cycle
    
    init(of size: Int) {
        self.size = size
        board = [[Int]]()
        for i in 0..<size {
            board.append([Int]((size*i+1)...(size*(i+1))))
        }
        board[size - 1][size - 1] = 0
        shuffle()
    }
    
    func shuffle() {
        let offsets = [(1,0),(0,1),(-1,0),(0,-1)]
        var (i,j) = blankPosition
        for _ in 1...(size * size * size) {
            let (offX, offY) = offsets[Int(arc4random()) % offsets.count]
            let k = (i + offX) < 0 ? 0 :
                (i + offX) == size ? size-1 : (i + offX)
            let l = (j + offY) < 0 ? 0 :
                (j + offY) >= size ? size-1 : (j + offY)
            if i != k || j != l {
                swap(&board[k][l], &board[i][j])
                i = k
                j = l
            }
        }
    }
    
    var blankPosition: (row: Int, col: Int) {
        return positionOf(number: 0)!
    }
    
    func positionOf(number: Int) -> (row: Int, col: Int)? {
        guard (0..<size * size).contains(number) else {
            return nil
        }
        let i = board.index(where: { $0.contains(number)})!
        return (i, board[i].index(where: { $0 == number })!)
    }
    
    func tileIsAdjancedToBlank(tileWith number: Int) -> Bool {
        guard let (i, j) = positionOf(number: number) else {
            return false
        }
        let (blankRow, blankCol) = blankPosition
        
        return
            i == blankRow + 1 && j == blankCol ||
            i == blankRow - 1 && j == blankCol ||
            i == blankRow && j == blankCol + 1 ||
            i == blankRow && j == blankCol - 1 
    }
    
    var movableTiles: [(row: Int, col: Int)] {
        let offsets = [(1,0),(0,1),(-1,0),(0,-1)]
        let (i, j) = blankPosition
        return offsets.flatMap {
            (offX, offY) in
            let k = (i + offX) < 0 ? nil :
                (i + offX) == size ? nil : (i + offX)
            let l = (j + offY) < 0 ? nil :
                (j + offY) >= size ? nil : (j + offY)
            if let x = k, let y = l {
                return (x,y)
            } else {
                return nil
            }
        }
    }
    
    func switchBlank(with tileNumber: Int){
        let (i, j) = positionOf(number: tileNumber)!
        let (blankRow, blankCol) = blankPosition
        swap(&board[i][j], &board[blankRow][blankCol])
        
        delegate?.puzzleDidSwitchTiles(puzzle: self, firstTilePos: (i,j), secondTilePos: (blankRow, blankCol))
        
        if solved {
            delegate?.puzzleIsSolved(puzzle: self)
        }
    }
    
    var solved: Bool {
        if board[size - 1][size - 1] != 0 { return false }
        for i in  0..<size {
            for j in 0..<size {
                if i == size - 1 && j == size - 1 && board[i][j] == 0 {
                    return true
                } else if board[i][j] != i * size + j + 1 {
                    return false
                }
            }
        }
        return true
    }

}
