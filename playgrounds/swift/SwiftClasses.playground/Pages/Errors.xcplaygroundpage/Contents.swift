//: [Previous](@previous)

import Foundation

//: ### Consider an Optional
func gcd(_ a: Int, _ b: Int) -> Int? { // greatest common divisor
    guard a > 0 else { return nil }
    if b == 0 { return a }
    return gcd(b, a % b)
}

if let result = gcd(5, -5) {
    result
}
else {
    "error"
}
//: ### Error Protocol
enum ErrorCases: Error {
    case outOfBounds
    case invalidArgument(value: Int)
}
//: ### Optional Wrapping

//: ### Error Suppression
//
//: ### Error Handling
do {

}
catch ErrorCases.invalidArgument(let value) {
    print("Invalid Argument Value: \(value)")
}
catch {
    print("error")
}
//: ### Defer
defer {
    print("And they lived happily ever after!")
}

//: [Next](@next)
