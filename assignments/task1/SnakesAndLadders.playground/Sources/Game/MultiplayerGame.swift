import Foundation

// Game

public protocol MultiplayerGame: Game {
    var players: [Player] { get }
    func join(player: Player)
}

// Delegates

public protocol MultiplayerGameDelegate: GameDelegate {
    func player(_ player: Player, didJoinTheGame game: MultiplayerGame)
    func player(_ player: Player, didTakeAction action: PlayerAction)
}

public protocol MultiplayerTurnbasedGameDelegate: TurnbasedGameDelegate, MultiplayerGameDelegate {
    func playerDidStartTurn(_ player: Player)
    func playerDidEndTurn(_ player: Player)
}

// Default Implementation

extension MultiplayerGameDelegate {
    public func player(_ player: Player, didJoinTheGame game: MultiplayerGame) {
        print("\(player.name) has joined the game")
    }
    
    public func player(_ player: Player, didTakeAction action: PlayerAction) {
        switch action {
        case .win:
            print("\(player.name) wins!")
        case let .move(square):
            print("\(player.name) moves to \(square)!")
        case let .special(_, explanation):
            print("\(player.name) \(explanation)")
        }
    }
}

extension MultiplayerTurnbasedGameDelegate {
    public func playerDidStartTurn(_ player: Player) {}
    public func playerDidEndTurn(_ player: Player) {}
}
