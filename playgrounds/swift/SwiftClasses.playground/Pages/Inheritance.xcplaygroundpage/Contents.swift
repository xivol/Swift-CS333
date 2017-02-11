//: ## Inheritance
//: [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
//: ****
import Foundation
//: ### Superclass
class Student {
    let name: String
    var course: UInt8
    let group: UInt8
    
    init(name: String, course: UInt8, group: UInt8){
        self.name = name
        self.course = course
        self.group = group
    }
    
    var description: String {
        return "\(name) \(course).\(group)"
    }
}
let student = Student(name: "John Smith", course: 1, group: 9)
//: ### Subclass and Overriding
class Graduate: Student {
    let graduationDate: Date = Date()
    
    override var description: String {
        return super.description + " \(graduationDate)"
    }
}
//: If no designated initializers are defined, designated initializers are inherited from the superclass
let grad = Graduate(name: "Will Smith", course: 1, group: 8)
grad.name
grad.graduationDate

class MastersStudent: Student {
    let programme: String
    
    init(name: String, programme: String, course: UInt8, group: UInt8){
        self.programme = programme
        super.init(name: name, course: course, group: group)
    }
    
    override var description: String {
        return super.description + " \(programme)"
    }
}
let master = MastersStudent(name: "Mike Smith", programme: "Computer Science", course: 1, group: 4)
master.name
master.programme
//: ### Downcasting and Upcasting
var students = [grad, master]
type(of: students)
var gradCount = 0
var mastersCount = 0

for s in students {
    if s is Graduate {
        gradCount += 1
    }
    else if s is MastersStudent {
        mastersCount += 1
    }
    s.description
}

if let g = students[0] as? Graduate {
    g.graduationDate
}
let m = students[1] as! MastersStudent
//: ### `Any` and `AnyObject` Superclasses
var manyObjects = [AnyObject]()
manyObjects.append(student)
manyObjects.append(grad)
manyObjects.append(master)

for m in manyObjects {
    switch m {
    case is Student:
        (m as! Student).description
    case is Graduate:
        (m as! Graduate).description
    case is MastersStudent:
        (m as! MastersStudent).description
    default:
        break
    }
}

var many = [Any]()
many.append(12)
many.append(student)

if var i = many[0] as? Int {
    i += 1
    many[0] = i
}
//: ****
//: [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
