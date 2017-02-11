//: [Previous](@previous)

protocol Descriptable {
    var description: String { get }
}
class Student: Descriptable {
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

var value: Descriptable = Student(name: "John", course: 1, group: 2)
value.description

extension Descriptable {
    var description: String {
        return "\(self)"
    }
}


extension Int: Descriptable {}
print(4.description)

struct Point {
    var x = 0.0, y = 0.0
}
extension Point: CustomStringConvertible {
    var description: String {
        return "\(x), \(y)"
    }
}
let p = Point(x: 5, y: 10)
print(p)
//: [Next](@next)
