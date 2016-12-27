import Foundation

public protocol SnakesAndLaddersDelegate: MultiplayerTurnbasedGameDelegate, DiceGameDelegate {}

public class SnakesAndLadders: DiceGame, MultiplayerGame, TurnbasedGame {
    public let name = "Snakes and Ladders"
    
    public let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var board: [Int]
    let finalSquare = 25
    
    public var delegate: SnakesAndLaddersDelegate?
    
    public init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
        players = [SALPlayer]()
    }

    public var players: [Player]
    
    public func join (player: Player) {
        players.append(player)
        delegate?.player(player, didJoinTheGame: self)
    }
    
    var numberOfTurns = 0
    
    public var turns: Int {
        get{return numberOfTurns}
    }
    
    public func play() {
        delegate?.gameDidStart(self)
        // set players starting position
        for var p in players {
            p.score = 0
        }
        
        gameLoop: while true {
            numberOfTurns += 1
            delegate?.gameDidStartTurn(self)
            for var p in players {
                
                delegate?.playerDidStartTurn(p)
                
                let diceRoll = (p as! DiceGamePlayer).roll(dice)
                delegate?.game(self, didDiceRoll: diceRoll)
            
                switch p.score + diceRoll {
                case finalSquare:
                    delegate?.player(p, didTakeAction: .win)
                    break gameLoop
                case let newSquare where newSquare > finalSquare:
                    // move player back if they didn't lend on the last square
                    p.score = 2 * finalSquare - newSquare
                    delegate?.player(p, didTakeAction: .special(square: p.score, explanation:"went back"))
                default:
                    p.score += diceRoll
                    delegate?.player(p, didTakeAction: .move(square: p.score))
                    // move player up or down
                    if board[p.score] > 0 {
                        delegate?.player(p, didTakeAction:.special(square: p.score, explanation: "went up a ladder"))
                    }
                    else if board[p.score] < 0{
                        delegate?.player(p, didTakeAction:.special(square: p.score, explanation: "slid down a snake"))
                    }
                    p.score += board[p.score]
                }
                delegate?.playerDidEndTurn(p)
            }
        }
        delegate?.gameDidEnd(self)
    }
}
