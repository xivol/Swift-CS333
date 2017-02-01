/*:
 ## Dictionaries
 [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
 ****
 */
import Foundation
var credits = ["Блохин" : 60, "Валиева" : 85, "Захарова" : 60, "Квачев" : 85, "Литовченко" : 80, "Орищенко" : 85, "Стребежев" : 97, "Тананакин" : 90]

for (name, points) in credits {
    "\(name) | \(points)"
}

credits.removeValue(forKey: "Блохин")
credits["Абрамов"] = 99

credits.count

for name in credits.keys {
    name.lowercased()
}

//: ****
//:  [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)