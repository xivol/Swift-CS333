import Foundation

// Game

public protocol TurnbasedGame: Game {
    var turns: Int { get }
}

// Delegate

public protocol TurnbasedGameDelegate: GameDelegate {
    func gameDidStartTurn(_ game: TurnbasedGame)
    func gameDidEndTurn(_ game: TurnbasedGame)
}

// Default Implementation

extension TurnbasedGameDelegate {
    public func gameDidStartTurn(_ game: TurnbasedGame) {}
    public func gameDidEndTurn(_ game: TurnbasedGame) {}
    
    public func gameDidEnd(_ game: Game) {
        print("The game lasted for \((game as! TurnbasedGame).turns) turns")
    }
}
