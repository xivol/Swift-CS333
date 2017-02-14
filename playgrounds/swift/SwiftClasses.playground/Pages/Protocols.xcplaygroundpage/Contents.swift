//: ## Protocols
//: [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
//: ****
//: ### Protocol Requrements
protocol Printable {
    func printMe()
}
//: ### Conforming to a Protocol
struct Student: Printable {
    let name: String
    var course: UInt8
    let group: UInt8
    
    func printMe() {
        print("\(name) \(course).\(group)")
    }
}
let john = Student(name: "John Smith", course: 1, group: 9)
//: ### Protocol Adoption
protocol Person {
    var name: String { get }
}
extension Student: Person {} // already has a name
//: ### Protocol Inheritace
import Foundation
protocol RealPerson: Person {
    var birthDate: Date { get }
}
class Citizen: RealPerson {
    let name: String
    let birthDate: Date
    let country: String
    
    init(name: String, birthDate: Date, country: String){
        self.name = name
        self.birthDate = birthDate
        self.country = country
    }
}

let formatter = DateFormatter()  // Date ⇆ String
formatter.dateFormat = "dd.MM.yyyy"

let anna = Citizen(name: "Anna Smith", birthDate: formatter.date(from: "01.01.1997")!, country: "Sweden")
//: ### Protocol as a Type
var people = [Person]()
people.append(john)
people.append(anna)
//: ### Checking for Conformance
for person in people {
    
    if person is Printable {
        print("\(person.name) is printable:", separator: "", terminator: " ")
        (person as! Printable).printMe()
    }
    
    if let realPerson = person as? RealPerson {
        print("\(realPerson.name) \(formatter.string(from: realPerson.birthDate))")
    } else {
        print("\(person.name) is not a RealPerson")
    }
}
//: ### Associated Types
protocol Stack {
    associatedtype Element
    mutating func push(value: Element)
    mutating func pop() -> Element?
}

struct StackOfInt: Stack {
    var items = [Int]()
    mutating func push(value: Int) {
        items.append(value)
    }
    mutating func pop() -> Int? {
        if let value = items.last {
            items.removeLast()
            return value
        }
        return nil
    }
}
//: ****
//: [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
