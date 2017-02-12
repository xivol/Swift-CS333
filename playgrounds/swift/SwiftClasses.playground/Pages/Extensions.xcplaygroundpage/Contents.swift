//: ## Extensions
//: [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
//: ****
//: ### Computed Properties
extension Double {
    // metric
    var km: Double { return self * 1_000.0 }
    var  m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    // imperial
    var   i: Double { return self.cm * 2.54 }
    var  ft: Double { return self / 3.28084 }
    var mil: Double { return self * 1609.34 }
}

let height = 5.0.ft + 6.0.i
let length = 1.0.km
//: ### Methods
extension Int {
    func times(action: (Int) -> Void) {
        for i in 0..<self {
            action(i)
        }
    }
}
3.times { print("\($0): Hello, Extension!") }

extension String {
    mutating func transform(with closure: (String) -> String) {
        self = closure(self)
    }
}
var str = "Hello, Exception"
str.transform { $0 + "!!!" }
str
//: ### Extension for Protocol Confarmance
struct Point {
    var x = 0.0, y = 0.0
}
extension Point: CustomStringConvertible { // standart protocol for string representation
    var description: String {
        return "(\(x), \(y))"
    }
}
Point(x: 1, y: 1)
//: ### Protocol Extension
extension CustomStringConvertible {
    func printMe() {
        print("I am \(self)")
    }
}
Point(x: 12, y: 24).printMe()
3.14.printMe()
(0...10).printMe()
//: ### Protocol Extension with Default Implementation
protocol Repeatable {
    func repeated(times: Int) -> [Self]
}
extension Repeatable {
    func repeated(times: Int) -> [Self] {
        return [Self](repeating: self, count: times)
    }
}
extension String: Repeatable {}
extension Double: Repeatable {}
"😀".repeated(times: 3)
3.14.repeated(times: 5)
//: ### Protocol Extension with Constraints
import Foundation
extension Collection where Iterator.Element: Repeatable {
    func expand(times: Int) -> [[Iterator.Element]] {
        var result = Array<[Iterator.Element]>()
        for el in self {
            result.append(el.repeated(times: times))
        }
        return result
    }
}
let matrix = [0.0, 0.1, 0.2, 0.3].expand(times: 4)
//: ****
//: [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
