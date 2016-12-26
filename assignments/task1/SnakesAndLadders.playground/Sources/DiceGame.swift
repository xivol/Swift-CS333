import Foundation

public protocol DiceGame {
    var dice: Dice { get }
    func play()
}

public protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func gameDidEnd(_ game: DiceGame)
}

public protocol TurnbasedGameDelegate {
    func gameDidStartTurn(_ game: DiceGame)
    func gameDidEndTurn(_ game: DiceGame)
}
