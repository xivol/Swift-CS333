//: __Snakes and Ladders__ — is an ancient Indian board game regarded today as a worldwide classic. It is played between two or more players on a gameboard having numbered, gridded squares. A number of "ladders" and "snakes" are pictured on the board, each connecting two specific board squares. The object of the game is to navigate one's game piece, according to die rolls, from the start (bottom square) to the finish (top square), helped or hindered by ladders and snakes respectively.
//:
//: ![SnakesAndLadders](SnakesAndLadders.jpg)

let directions = [(4,14), (17,7), (9,31), (62,19), (20,38), (87,24), (28,84), (54,34),
                  (40,59), (51,67), (64,60), (63,81), (71,91), (93,73), (95,75), (99,78) ]

let game = SnakesAndLadders(fieldSize: 100, snakesAndLadders: directions)

game.delegate = SnakesAndLaddersTracker()

for name in ["Alice", "Maria", "Alex", "Ivan"]{
    game.join(player: SnakesAndLaddersPlayer(name: name))
}

game.play()
