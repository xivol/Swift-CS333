//: ## Value and Reference Types
//: [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
//: ****
import Foundation
struct Student {
    let name: String
    var course: UInt8
    let group: UInt8
}
let john = Student(name: "John Smith", course: 1, group: 9)
//: Structures are value types
var anotherJohn = john
anotherJohn.course += 1
john.course != anotherJohn.course
//: 
class CreditsBook {
    let student: Student
    var credits: [String:Int]
    init(student: Student, credits: [String:Int]) {
        self.credits = credits
        self.student = student
    }
    deinit {
        print ("\(student.name)'s book is being deinitialized")
    }
}
let johnsBook = CreditsBook(student: john, credits: [:])
johnsBook.credits["Programming 101"] = 89
//: Classes are reference types
let anotherBook = johnsBook
anotherBook.credits["Calculus"] = 80
anotherBook.credits == johnsBook.credits
//: Refernce comparision
anotherBook === johnsBook
//: ### Automatic Refernce Counting
//: ARC works for every reference type object
var arcBook: CreditsBook? = CreditsBook(student: john, credits: [:])
var arcBookRef = arcBook

arcBook = nil
arcBookRef?.student.name
arcBookRef = nil
//: ### Strong Reference Cycles
class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}
var mike: Person? = Person(name: "Mike Smith")
var mikesPlace: Apartment? = Apartment(unit: "205")

print("Single Refernce:")
mike = nil
mikesPlace = nil

var will: Person? = Person(name: "Will Smith")
var willsPlace: Apartment? = Apartment(unit: "101")

will?.apartment = willsPlace
willsPlace?.tenant = will

print("Cycled Refernce:")
will = nil
willsPlace = nil
print("Nothing!")
//: ### Weak and Unowned Refernces
class Pet{
    let species: String
    let name: String
    init(type: String, name: String) {
        self.species = type
        self.name = name
    }
    weak var owner: Person?
}
var jenifer: Person? = Person(name: "Jenifer Smith")
var fluffyTheCat = Pet(type: "Cat", name: "Fluffy")
fluffyTheCat.owner = jenifer

print("Weak Refernce:")
jenifer = nil
fluffyTheCat.owner?.name

class Phone {
    unowned var owner: Person
    let number: String = String(arc4random())
    init(owner: Person) { self.owner = owner }
}
var anna: Person? = Person(name: "Anna Smith")
let annasPhone = Phone(owner: anna!)
annasPhone.number

print("Unowned Refernce:")
anna = nil
//annasPhone.owner.name
//: ****
//: [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)

