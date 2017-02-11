//: [Previous](@previous)

import Foundation

enum MyError: Error {
    case outOfBounds
    case invalidArgument(i: Int)
}

func calc(i: Int, j: Int) throws -> Int {
    guard i > 0 else {
        throw MyError.invalidArgument(i: i)
    }
    guard j > 0 else {
        throw MyError.invalidArgument(i: i)
    }
    return i+j
}
print(try? calc(i: 5, j: -1))

do {
    try calc(i: 10, j: -10)
}
catch MyError.invalidArgument(_) {
        print("Invalid Argument")
}
catch {
    print("error")
}
defer {
    print("error happened")
}

//: [Next](@next)
