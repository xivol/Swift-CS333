//
//  ViewController.swift
//  15-puzzle
//
//  Created by Илья Лошкарёв on 19.02.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PuzzleDelegate {
    var puzzle: Puzzle!
    var size = 2
    let maxSize = 10
    
    var buttons = [[UIButton]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetPuzzle()
    }
    
    func resetPuzzle(){
        if let oldPuzzle = view.subviews.first {
            cleanup(oldPuzzle)
        }
        puzzle = Puzzle(of: size)
        puzzle.delegate = self // potential cycle
        initUI()

    }
    
    func cleanup(_ container: UIView) {
        container.removeFromSuperview()
        buttons = [[UIButton]]()
    }
    
    func initUI() {
        let container = UIView(frame: CGRect(x: 0, y: (view.bounds.height - view.bounds.width) / 2,
                                             width: view.bounds.width, height: view.bounds.width))
        container.backgroundColor = UIColor.white
        
        let buttonSize = CGSize(width: container.bounds.width / CGFloat(puzzle.size),
                                height: container.bounds.width / CGFloat(puzzle.size))
        for i in 0..<puzzle.size {
            buttons.append([UIButton]()) // new row
            for j in 0..<puzzle.size {
                let button = createGridButton(row: i, col: j, of: buttonSize)
                button.addTarget(self, action: #selector(buttonTouched(sender:)), for: .touchUpInside)
                buttons[i].append(button)
                container.addSubview(button)
            }
        }
        view.addSubview(container)
    }
    
    func createGridButton(row: Int, col: Int, of size: CGSize) -> UIButton {
        let buttonOrigin = CGPoint(x: CGFloat(col) * size.width, y: CGFloat(row) * size.height)
        var button: UIButton!
        if puzzle.board[row][col] == 0 { // empty tile
            button = UIButton(frame: CGRect(origin: buttonOrigin, size: size))
        } else {
            button = RadialGradientButton.puzzleTile(frame: CGRect(origin: buttonOrigin, size: size),
                                                     color: UIColor.random)
        }
        button.setTitle("\(puzzle.board[row][col])", for: .normal)
        return button
    }
    
    // if buttons are animated
    var isAnimating: Bool {
        for button in buttons.flatMap({$0}) {
            if (button.layer.animationKeys()?.count ?? 0) > 0 {
                return true
            }
        }
        return false
    }
    
    // MARK: Actions
    
    func buttonTouched(sender: UIButton) {
        guard let number = Int(sender.title(for: .normal)!), !isAnimating
        else { return }
        if puzzle.tileIsAdjancedToBlank(tileWith: number) {
            puzzle.switchBlank(with: number)
        } else {
            // animate movable tiles
            for tile in puzzle.movableTiles {
                let shakeDirection = 5 * CGPoint(x: puzzle.blankPosition.col - tile.col,
                                                 y: puzzle.blankPosition.row - tile.row)
                let button = buttons[tile.row][tile.col]
                
                UIView.animate(withDuration: 0.1) {
                    button.center += shakeDirection
                }
                UIView.animate(withDuration: 0.1, delay: 0.09, options: .curveLinear, animations: {
                    button.center -= shakeDirection
                })
            }
        }
    }

    // MARK: PuzzleDelegate
    
    func puzzleDidSwitchTiles(puzzle: Puzzle, firstTilePos: (Int, Int), secondTilePos: (Int, Int)) {
        let (i,j) = firstTilePos
        let (k,l) = secondTilePos
        let centerFirst = buttons[i][j].center
        let centerSecond = buttons[k][l].center
        UIView.animate(withDuration: 0.2) {
            self.buttons[i][j].center = centerSecond
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.buttons[k][l].center = centerFirst
        }, completion: { _ in
            swap(&self.buttons[i][j], &self.buttons[k][l])
        })
    }
    
    func puzzleIsSolved(puzzle: Puzzle) {
        if isAnimating {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { [weak self](_) in
                self?.puzzleIsSolved(puzzle: puzzle)
            }
            return
        }
        let alert = UIAlertController(title: "☆ Congratulations ☆", message: "You've cleared rank \(size)!", preferredStyle: UIAlertControllerStyle.alert)
        if size < maxSize {
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
                //self.clearUI()
                self.buttons = [[UIButton]]()
                self.size += 1
                self.resetPuzzle()
            }))
        } else { // finished the game
            alert.addAction(UIAlertAction(title: "Start again!", style: .default, handler: {_ in
                self.size = 2
                self.resetPuzzle()
            }))
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    

    
}

