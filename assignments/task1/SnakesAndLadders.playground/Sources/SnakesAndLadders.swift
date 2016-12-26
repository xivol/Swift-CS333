import Foundation

public class SnakesAndLadders: DiceGame, MultiplayerGame {
    
    let finalSquare = 25
    public let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var board: [Int]
    
    public init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
        players = [Player]()
    }

    public var delegate: MultiplayerDiceGameDelegate?
    
    public var players: [Player]
    
    public func join (player: Player) {
        players.append(player)
        player.position = 0
    }
    
    public func play() {
        delegate?.gameDidStart(self)
        gameLoop: while true {
            delegate?.gameDidStartTurn(self)
            for p in players {
                let diceRoll = p.roll(dice)
            
                delegate?.player(p, didStartNewTurnWithDiceRoll: diceRoll)
            
                switch p.position + diceRoll {
                case finalSquare:
                    delegate?.playerWon(p)
                    break gameLoop
                case let newSquare where newSquare > finalSquare:
                    p.position = 2 * finalSquare - newSquare
                default:
                    p.position += diceRoll
                    p.position += board[p.position]
                }
            }
        }
        delegate?.gameDidEnd(self)
    }
}
