//: Playground - noun: a place where people can play

import UIKit

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()
