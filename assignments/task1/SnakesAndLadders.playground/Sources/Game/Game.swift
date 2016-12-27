import Foundation

// Game

public protocol Game {
    var name: String { get }
    func play()
}

// Delegates

public protocol GameDelegate {
    func gameDidStart(_ game: Game)
    func gameDidEnd(_ game: Game)
}

// Default Implementation

extension GameDelegate {
    public func gameDidStart(_ game: Game) {
        print("Started a new game of \(game.name)")
    }
    
    func gameDidEnd(_ game: Game) { }
}
