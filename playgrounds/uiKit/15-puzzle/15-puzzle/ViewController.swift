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
    let maxSize = 6
    
    var buttons: [[UIButton]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetPuzzle()
        // Init gesture recognition
        let swipeDirections: [UISwipeGestureRecognizerDirection] = [.down, .up, .left, .right]
        for direction in swipeDirections {
            let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(gesture(recognizer:)))
            recognizer.direction = direction
            view.addGestureRecognizer(recognizer)
        }
    }
    
    func resetPuzzle(){
        buttons = [[UIButton]]()
        var size = puzzle?.size ?? 1
        size = (size == maxSize) ? 1 : size
        puzzle = Puzzle(of: size + 1)
        puzzle.delegate = self // potential cycle
        initBoard()
    }
    
    func initBoard() {
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
        if let oldContainer = view.subviews.first {
            UIView.transition(from: oldContainer, to: container,
                              duration: 1,
                              options: .transitionFlipFromRight,
                              completion: nil)
        } else {
            view.addSubview(container)
        }
        
    }
    
    func createGridButton(row: Int, col: Int, of size: CGSize) -> UIButton {
        let buttonOrigin = CGPoint(x: CGFloat(col) * size.width, y: CGFloat(row) * size.height)
        var button: UIButton!
        if puzzle.board[row][col] == 0 {
            // Empty Tile
            button = UIButton(frame: CGRect(origin: buttonOrigin, size: size))
            button.setTitleColor(UIColor.clear, for: .normal)
        } else {
            button = RadialGradientButton.puzzleTile(frame: CGRect(origin: buttonOrigin, size: size),
                                                     color: UIColor.random)
        }
        button.setTitle("\(puzzle.board[row][col])", for: .normal)
        return button
    }
    
    // If buttons are animated
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
        guard let number = Int(sender.title(for: .normal)!) else { return }
        
        if puzzle.tileIsAdjancedToBlank(tileWith: number) {
            puzzle.switchBlank(with: number)
        } else {
            // animate movable tiles
            for tile in puzzle.movableTiles {
                let button = buttons[tile.row][tile.col]
                let shakeDirection = button.frame.width * 0.1 * CGPoint(x: puzzle.blankPosition.col - tile.col,
                                                 y: puzzle.blankPosition.row - tile.row)
                
                view.isUserInteractionEnabled = false // disable interactions
                UIView.animate(withDuration: 0.1) {
                    button.center += shakeDirection
                }
                UIView.animate(withDuration: 0.1, delay: 0.09, options: .curveLinear, animations: {
                    button.center -= shakeDirection
                }, completion: { [weak self] _ in
                    self?.view.isUserInteractionEnabled = true // enable interactions
                })
            }
        }
    }
    
    func gesture(recognizer: UISwipeGestureRecognizer) {
        let tiles = puzzle.movableTiles
        let tileDirections = puzzle.movableTiles.flatMap {
            (row, col) -> UISwipeGestureRecognizerDirection? in
            switch (puzzle.blankPosition.col - col, puzzle.blankPosition.row - row) {
            case (1,0):
                return UISwipeGestureRecognizerDirection.right
            case (-1,0):
                return UISwipeGestureRecognizerDirection.left
            case (0,1):
                return UISwipeGestureRecognizerDirection.down
            case (0,-1):
                return UISwipeGestureRecognizerDirection.up
            default:
                print("Unexpected direction!")
                return nil
            }
        }
        if let index = tileDirections.index(of: recognizer.direction) {
            let (i,j) = tiles[index]
            puzzle.switchBlank(with: puzzle.board[i][j])
        }
    }

    // MARK: PuzzleDelegate
    
    func puzzleDidSwitchTiles(puzzle: Puzzle, firstTilePos: (Int, Int), secondTilePos: (Int, Int)) {
        let (i,j) = firstTilePos
        let (k,l) = secondTilePos
        let centerFirst = buttons[i][j].center
        let centerSecond = buttons[k][l].center
        view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.2) {
            self.buttons[i][j].center = centerSecond
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.buttons[k][l].center = centerFirst
        }, completion: { [weak self] _ in
            if self != nil {
                swap(&self!.buttons[i][j], &self!.buttons[k][l])
                self!.view.isUserInteractionEnabled = true
            }
        })
    }
    
    func puzzleIsSolved(puzzle: Puzzle) {
        if self.isAnimating {
            // Wait for animation to end
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { [weak self] _ in
                self?.puzzleIsSolved(puzzle: puzzle)
            }
            return
        }
        let confetti = ConfettiView(frame: view.bounds)
        let alert = UIAlertController(title: "☆ Congratulations ☆", message: "You've cleared rank \(puzzle.size)!", preferredStyle: UIAlertControllerStyle.alert)
        // Confetti
        //alert.view.addSubview(confetti)
        //alert.view.sendSubview(toBack: confetti)
        alert.view.insertSubview(confetti, at: 0)
        confetti.startConfetti()
        // Button
        let title = puzzle.size < maxSize ? "Next" : "Start again!"
        alert.addAction(UIAlertAction(title: title, style: UIAlertActionStyle.default){
            [weak confetti](_) in
            confetti?.stopConfetti()
            self.resetPuzzle()
        })
        // Present
        self.present(alert, animated: true, completion: nil)
    }

    
}

