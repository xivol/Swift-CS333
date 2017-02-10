/*:
 ## Tuples
 [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
 ****
 */
var pair: (String, Int)
pair.0 = "Swift"
pair.1 = 333

pair

var namedPair: (name: String, age: Int)
namedPair.name = "Ilya"
namedPair.age = 28

namedPair
//: Type inferrence
let point = (x: 0.0, y: -1.0)

type(of: point)

let area = (bottomLeft: (-1.0, -1.0), topRight: (1.0, 1.0))

type(of: area)
//: Tuples of the same type are comparable. Tuples are compared from left to right.
if point > area.bottomLeft && point < area.topRight {
    "point is inside the (\(area.bottomLeft), \(area.topRight)) area"
}

if point == (0.0, 0.0) {
    "point is zero"
} else if point.x > 0.0 {
    if point.y > 0.0 {
        "point is in first quarter"
    } else {
        "point is in fourth quarter"
    }
} else {
    if point.y < 0.0 {
        "point is in third quarter"
    } else {
        "point is in second quarter"
    }
}
//: _Tuples can be decomposed into a set of variables:_
var (first, second) = point
"first: \(first); second: \(second)"
type(of: first)

(first, second) = (second, first)
"swapped first: \(first); second: \(second)"
//: _Underscore `_` can be used to ignore some of tuple values._
let (onlyFirst, _) = point
"first: \(onlyFirst)"
//: _It can also be used in switch cases:_
switch point {
case (0.0, 0.0):
    break
case (0.0, _):
    "point belongs to the X axis"
case (_, 0.0):
    "point belongs to the Y axis"
default:
    break
}
//: _(Type) ~ Type_
type(of: ("Hello, Tuple!"))
type(of: (42))
type(of: ()) // () ~ Void
//: [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
