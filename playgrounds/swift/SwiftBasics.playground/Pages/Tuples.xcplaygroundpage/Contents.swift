/*:
 # Tuples
 [⬅️](@previous) · [⬆️](TableOfContents) · [➡️](@next)
 ****
 */
import Foundation
//: _All collections are part of Foundation library._
var pair: (String, Int)
pair.0 = "Swift"
pair.1 = 333

print(pair)

var namedPair: (name: String, age: Int)
namedPair.name = "Ilya"
namedPair.age = 28

print(namedPair)

let point = (x: 0.0, y: -1.0)
print( type(of: point) )

let area = (bottomLeft: (-1.0, -1.0), topRight: (1.0, 1.0))
//: _Tuples are compared from left to right._
if point > area.bottomLeft && point < area.topRight {
    print("point is inside the (\(area.bottomLeft), \(area.topRight)) area")
}

if point == (0.0, 0.0) {
    print("point is Zero")
} else if point.x > 0.0 {
    if point.y > 0.0 {
        print("point is in first quarter")
    } else {
        print("point is in fourth quarter")
    }
} else {
    if point.y < 0.0 {
        print("point is in third quarter")
    } else {
        print("point is in second quarter")
    }
}
//: _Tuples can be decomposed into a set of variables:_
var (first, second) = point
print( "first: \(first); second: \(second)")

(first, second) = (second, first)
print( "swapped: first: \(first); second: \(second)")
//: _Underscore '\_' can be used to ignore some of tuple values._
let (onlyFirst, _) = point
print( "first: \(onlyFirst)")
//: _It can also be used in switch cases:_
switch point {
case (0.0, 0.0):
    break
case (0.0, _):
    print("point belongs to the X axis")
case (_, 0.0):
    print("point belongs to the Y axis")
default:
    break
}
//: _(Type) ~ Type_
type(of: ("Hello, Swift!"))
type(of: (42))
type(of: ()) // () ~ Void
//: [⬅️](@previous) · [⬆️](TableOfContents) · [➡️](@next)
