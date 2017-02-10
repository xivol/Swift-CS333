/*:
 ## Dictionaries
 [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
 ****
 */
import Foundation

var credits: [String:Int]

credits = [:]
credits["Student1"] = 60
credits["Student2"] = 65
credits["Student3"] = 71

for (name, points) in credits {
    "\(name) | \(points)"
}

for name in credits.keys {
    name.lowercased()
}

let avg = credits.values.reduce(0, { $0 + $1}) / credits.count
avg


if let oldValue = credits.updateValue( 85, forKey: "Student1") {
    "The old value was \(oldValue)"
}

if let oldValue = credits.removeValue(forKey: "Student1") {
    "The old value was \(oldValue)"
}
//:
let assignments = [ "Toying with Swift":15, "The Calculator":15,
                    "The Calculator 2":15, "The Memesis":20,
                    "The Timetable":15, "The Stargazer":20
]
type(of:assignments)

let minimumRequired = assignments.filter {
    (key, value) in
    return value == assignments.values.min()!
}
type(of: minimumRequired)

let sumOfCredits = minimumRequired.reduce(0){
    $0 + $1.1
}

//: - Experiment:
//:
//: ****
//:  [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
