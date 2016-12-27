//: Playground - noun: a place where people can play

import UIKit

let tracker = SnakesAndLaddersTracker()
let game = SnakesAndLadders()
game.delegate = tracker
for name in ["Alice", "Maria", "Alex", "Ivan"]{
    game.join(player: SALPlayer(name: name))
}
game.play()
