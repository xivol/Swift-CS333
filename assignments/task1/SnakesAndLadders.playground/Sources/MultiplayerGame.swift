import Foundation

public protocol MultiplayerGame {
    func join( player: Player)
    var players: [Player] { get }
}

public protocol MultiplayerDiceGameDelegate: DiceGameDelegate, TurnbasedGameDelegate {
    func player(_ player: Player, didStartNewTurnWithDiceRoll diceRoll: Int)
    func playerWon(_ player: Player)
}
