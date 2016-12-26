//: Playground - noun: a place where people can play

import UIKit

let tracker = MultiplayerDiceGameTracker()
let game = SnakesAndLadders()
for name in ["Alice", "Maria", "Alex", "Ivan"]{
    game.join(player: Player(name: name))
}
game.delegate = tracker
game.play()
