//: ## Basic Syntax
//: [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)//: ****
//: ### Constants and Variables
let constant = "Constants are declared with 'let'"
// constant = "You can not change a constant!"
//: _It is considered a good practice to declare any value as a constant until you have a need to change it to a variable._
var variable = "Variables are declared with 'var'"
variable = "You can assign a new value to a variable"
//: You can declare multiple constants or variables in one line if you separate them with a comma:
let a = 0, b = 0, c = 0
//:### Basic Types
let boolean: Bool = true

let long: Int = Int.max  // Int64 for x64 systems
let integer: Int32 = Int32.max
let short: Int16 = Int16.max
let byte: Int8 = Int8.max
let ubyte: UInt8 = UInt8.max // there are also UInt16, UInt32, UInt62

let pi: Double = 3.141592653589793
let e: Float = 2.71828182
//: Type of a value can be inferred from the declaration
let i = 0x2a

"i is inferred as \(type(of: i))"

let π = 3.14
"π is inferred as \(type(of: π))"

let star = "⭐️"
"star is inferred as \(type(of: star))"
//:### Type Casting
//: There is no implicit type conversions in Swift.
let intPi = Int(pi)
let doubleE = Double(e)
//: But literals has no type, so the following is not a type conversion.
let fire: Character = "🔥"
let four: Double = 2 * 2
//:### Operators
let arithmetics = 1 + (2 * 3) - (5 / 4) % 2
let comparision = ((1 > 2) == (2 < 3)) != ((2 >= 3) == (3<=4))
let logic = (true && !false) || (!true && false)

let range = 1...3
let interval = 1..<10
//:### Control Flow
//: In Swift curved braces are required for control flow.
if comparision {
    "Comparision result is True"
} else {
    "Comparision result is False"
}

let signedValue = -1

if signedValue > 0  {
    "signedValue > 0"
} else if signedValue < 0 {
    "signedValue < 0"
} else {
    "signedValue == 0"
}

switch signedValue {
case Int.min..<0:
    "signedValue < 0"
case 0:
    "signedValue == 0"
default:
    "signedValue > 0"
}
//: _There is no implicit fallthrough in switch. Switch clausures must be exauhstive and every case should contain an action._
let switchValue = 34

switch switchValue {
case Int.min..<0:
    "switchValue is a negative number"
case 0:
    "switchValue is a zero"
case 1, 2, 3, 5, 8, 13, 21, 34, 55, 89:
    "\(switchValue) is one of the first 10 Fibonachi numbers"
default:
    break
}
//:_there are the basic loops in Swift_
for i in 1...10 {
    i % 2
}

var whileCondition = true
while whileCondition {
    whileCondition
    whileCondition = false
}

var repeatCondition = false
repeat {
    repeatCondition
} while repeatCondition
//: ****
//: [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
