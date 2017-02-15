import Foundation

public protocol SnakesAndLaddersDelegate: MultiplayerTurnbasedGameDelegate, DiceGameDelegate {}

public class SnakesAndLadders: DiceGame, MultiplayerGame, TurnbasedGame {
    public let name = "Snakes and Ladders"
    var board: [Int]
    let finalSquare: Int

    public var delegate: SnakesAndLaddersDelegate?

    public init(fieldSize size: Int, snakesAndLadders moves: [(from:Int, to:Int)]) {
        board = Array(repeating: 0, count: size + 1) // starting position beyond the first square
        finalSquare = size
        for move in moves {
            board[move.from] = move.to - move.from
        }
    }

    public convenience init() {
        self.init(fieldSize: 26, snakesAndLadders: [(3,11), (6,17), (9,18), (10,12), (14,4), (19,8), (22,20), (24,16)])
    }

    // MARK: - DiceGame

    public let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())

    // MARK: - MultyplayerGame

    public var players: [Player] = [SnakesAndLaddersPlayer]()

    public func join (player: Player) {
        players.append(player)
        delegate?.player(player, didJoinTheGame: self)
    }

    // MARK: - TurnbasedGame

    private var numberOfTurns = 0

    public var turns: Int {
        get { return numberOfTurns }
    }

    public var hasEnded: Bool {
        get {
            if players.count == 0 {
                return true
            }
            else {
                return players.filter({ p in p.score == finalSquare }).count > 0
            }
        }
    }

    public func start() {
        for var p in players {
            p.score = 0
        }
        delegate?.gameDidStart(self)
    }

    public func end() {
        delegate?.player(players.filter({ p in p.score == finalSquare }).first!, didTakeAction: .win)
        delegate?.gameDidEnd(self)
    }

    public func makeTurn() {
        numberOfTurns += 1
        delegate?.gameDidStartTurn(self)
        for var p in players {
            playerMakeTurn(&p)
            if self.hasEnded {
                break
            }
        }
        delegate?.gameDidEndTurn(self)
    }

    // MARK: - Player logic

    public func playerMakeTurn( _ player: inout Player) {
        delegate?.playerDidStartTurn(player)
        let diceRoll = dice.roll()
        delegate?.game(self, didDiceRoll: diceRoll)

        if (player.score + diceRoll) > finalSquare {

            // move player back if they didn't lend on the last square
            player.score = 2 * finalSquare - (player.score + diceRoll)

            delegate?.player(player, didTakeAction: .special(square: player.score, explanation:"went back"))
        }
        else {
            // move player forward
            player.score += diceRoll
            delegate?.player(player, didTakeAction: .move(square: player.score))

            let scoreAfterRoll = player.score
            // move player up or down
            player.score += board[player.score]
            // call delegate
            switch board[scoreAfterRoll] {
                // ladder
            case let ladder where ladder > 0:
                delegate?.player(player, didTakeAction:.special(square: player.score, explanation: "went up a ladder"))
                // snake
            case let snake where snake < 0:
                delegate?.player(player, didTakeAction:.special(square: player.score, explanation: "slid down a snake"))
            default:
                break
            }

        }
        delegate?.playerDidEndTurn(player)
    }

}
