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
    
    var buttons = [[UIButton]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        resetPuzzle()
    }
    
    func resetPuzzle(){
        puzzle = Puzzle(of: size)
        puzzle.delegate = self // potential cycle
        initUI()
    }
    
    func initUI() {
        let container = UIView(frame: CGRect(x: 0, y: (view.bounds.height - view.bounds.width) / 2,
                                         width: view.bounds.width, height: view.bounds.width))
        let buttonSize = CGSize(width: container.bounds.width / CGFloat(puzzle.size),
                                height: container.bounds.width / CGFloat(puzzle.size))
        for i in 0..<puzzle.size {
            buttons.append([UIButton]())
            for j in 0..<puzzle.size {
                let button = createGridButton(row: i, col: j, of: buttonSize)
                button.addTarget(self, action: #selector(buttonTouched(sender:)), for: .touchUpInside)
                buttons[i].append(button)
                container.addSubview(button)
            }
        }
        view.addSubview(container)
        container.backgroundColor = UIColor.white
    }
    
    func createGridButton(row: Int, col: Int, of size: CGSize) -> UIButton {
        let button = UIButton(type: .system)
        let buttonOrigin = CGPoint(x: CGFloat(col) * size.width, y: CGFloat(row) * size.height)
        button.frame = CGRect(origin: buttonOrigin, size: size)
        // Background
        if puzzle.board[row][col] != 0 {
            button.backgroundColor = UIColor.random
        } else {
            button.backgroundColor = UIColor.white
        }
        // Font
        button.setTitle("\(puzzle.board[row][col])", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(28)
        // Border
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = button.bounds.width * 0.2
        return button
    }
    
    func buttonTouched(sender: UIButton) {
        guard let number = Int(sender.title(for: .normal)!),
            number != 0
        else {
            return
        }
        if puzzle.hasNumberAdjancedToBlank(number) {
            puzzle.switchBlank(with: number)
        }
    }

    
    // MARK: PuzzleDelegate
    
    func puzzleDidSwitchTiles(puzzle: Puzzle, firstTilePos: (Int, Int), secondTilePos: (Int, Int)) {
        let (i,j) = firstTilePos
        let (k,l) = secondTilePos
        let frame = buttons[i][j].frame
        buttons[i][j].frame = buttons[k][l].frame
        buttons[k][l].frame = frame
        swap(&buttons[i][j], &buttons[k][l])
    }
    
    func puzzleIsSolved(puzzle: Puzzle) {
        let alert = UIAlertController(title: "Congratulations!", message: "You've cleared rank \(size)", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
            self.clearUI()
            self.size += 1
            self.resetPuzzle()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func clearUI() {
        guard buttons.count != 0 else {
            return
        }
        for i in 0..<puzzle.size {
            for j in 0..<puzzle.size {
                buttons[i][j].removeFromSuperview()
            }
        }
        for subview in view.subviews {
            subview.removeFromSuperview()
        }
        buttons = [[UIButton]]()
    }

}

