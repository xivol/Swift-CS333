import Foundation

public protocol Player {
    var name: String { get }
    var score: Int { get set }
}

public enum PlayerAction {
    case win
    case move(square: Int)
    case special(square: Int, explanation: String)
}
