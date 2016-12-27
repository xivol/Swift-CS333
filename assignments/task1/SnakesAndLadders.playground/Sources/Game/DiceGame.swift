import Foundation

// Game

public protocol DiceGame: Game {
    var dice: Dice { get }
}

// Delegates

public protocol DiceGameDelegate: GameDelegate {
    func game(_ game: DiceGame, didDiceRoll diceRoll: Int)
}

// Default Implementation

extension DiceGameDelegate {
    public func game(_ game: DiceGame, didDiceRoll diceRoll: Int) {
        print("Dice roll is a \(diceRoll)")
    }
}
