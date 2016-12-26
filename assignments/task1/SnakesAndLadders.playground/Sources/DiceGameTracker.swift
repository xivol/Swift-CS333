import Foundation

public class DiceGameTracker: DiceGameDelegate, TurnbasedGameDelegate {
    var numberOfTurns = 0
    public init(){}
    public func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    
    public func gameDidStartTurn(_ game: DiceGame) {
        numberOfTurns += 1
        print("Turn \(numberOfTurns)")
    }
    
    public func gameDidEndTurn(_ game: DiceGame) {}
    
    public func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

public class MultiplayerDiceGameTracker: DiceGameTracker, MultiplayerDiceGameDelegate {
    public func player(_ player: Player, didStartNewTurnWithDiceRoll diceRoll: Int) {
        print("\(player.name) rolled a \(diceRoll)")
    }
    
    public func playerWon(_ player: Player) {
        print("\(player.name) wins!")
    }
}
