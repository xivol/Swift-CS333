/*:
 ## Enumerations
 [Table of Contents](TableOfContents) · [Previous](@previous)
 ****
 */
import Foundation
//: ### Simple Enumerations
enum Direction{
    case up, down, left, right
}

Direction.up
//: ### Base Type
enum Suit: String {
    case spades = "♠️"
    case hearts = "♥️"
    case diamonds = "♦️"
    case clubs = "♣️"
}

Suit.spades.rawValue

enum Rank: Int {
    case two = 2, three, four, five, six, seven,
    eight, nine, ten, jack, queen, king, ace
}

let jack = Rank(rawValue: 11)
jack?.rawValue

//: ### Type Inferrance
let card: (Rank, Suit) = (.three, .hearts)
"\(card.0.rawValue) of \(card.1.rawValue)"

let allSuits: [Suit] = [.spades, .hearts, .diamonds,. clubs]
let allRanks: [Rank] = [.two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .jack, .queen, .king, .ace]

var deck: [(Rank, Suit)] = allSuits.flatMap {
    suit in allRanks.flatMap {
        rank in (rank, suit)
    }
}

for card in deck {
    "\(card.0) of \(card.1)".capitalized
}

//: ### Complex Enumerations
enum Solution {
    case noRealRoots
    case doubleRoot(Double)
    case twoRoots(Double, Double)
}

func solveQuadric(_ a: Double, _ b: Double, _ c: Double) -> Solution {
    let d = b * b - 4 * a * c
    if d < 0 {
        return .noRealRoots
    } else if d == 0 {
        return .doubleRoot(-b / (2 * a))
    } else {
        return .twoRoots((-b + sqrt(d)) / (2 * a), (-b - sqrt(d)) / (2 * a))
    }
}

let a = 1.0, b = -5.0, c = 6.0
let root = solveQuadric(a, b, c)

switch root {
case .noRealRoots:
    "Вещественных корней нет"
case .doubleRoot(let x):
    "Единственный корень: \(x)"
case .twoRoots(let x1, let x2):
    "Два корня: \(x1), \(x2)"
}
//: [Table of Contents](TableOfContents) · [Previous](@previous)
