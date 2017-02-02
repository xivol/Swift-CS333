/*:
 ## Dictionaries
 [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
 ****
 */
import Foundation

var credits = [String:Int]()
credits["Блохин"] = 60
credits["Валиева"] = 60

for (name, points) in credits {
    "\(name) | \(points)"
}

for name in credits.keys {
    name.lowercased()
}

let avg = credits.values.reduce(0, { $0 + $1}) / credits.count
avg

if let oldValue = credits.updateValue( 85, forKey: "Абрамов") {
    "The old value was \(oldValue)"
}

if let oldValue = credits.removeValue(forKey: "Блохин") {
    "The old value was \(oldValue)"
}
//: - Experiment:
//:
//: ****
//:  [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
