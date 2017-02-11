//: ## Computed Properties and Methods
//: [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
//: ****
struct Student {
    let name: String
    var course: UInt8
    let group: UInt8
}
let s = Student(name: "John Smith", course: 1, group: 9)
//: ### Declaration
struct CreditsBook {
    let student: Student
    var credits: [String:Int]
 
    var average: Float { // computed properties must be declared with var
        if credits.count == 0 {
            return 0
        }
        else {
            return Float(credits.values.reduce(0, {$0 + $1})) / Float(credits.count)
        }
    }
 
    func hasCourse(withName subject: String) -> Bool {
        return (credits.index(forKey: subject) != nil)
    }
}
 
 var sCredits = CreditsBook(student: s, credits: ["Programming 101":89])
 sCredits.hasCourse(withName: "Programming 101")
 sCredits.credits["Calculus"] = 80
 sCredits.average
/*:
 ### Access Modifiers
 - `public` - accessible from anywhere
 - `internal` - accessible from the current bundle - *default*
 - `fileprivate` - accessible from the current file
 - `private` - accessible to its owner
*/
struct PrivateCredits {
    let student: Student
    fileprivate var credits: [String:Int]  // private member
 
    // Initializer with empty credits
    init(student: Student) {
        self.init(student: student, credits: [:])
    }
 
    // Initializer with credits
    init(student: Student, credits: [String:Int]){
        self.student = student
        self.credits = credits
    }
}
var pCredits = PrivateCredits(student: s)
// p.Credits.credits
//: Non-modifiing methods can be added to classes or structures with extensions
extension PrivateCredits {
    func getCredit(for subject: String) -> Int? {
        return credits[subject] // accessible in extension due to fileprivate modifier
    }
 
    func hasCredit(for subject: String) -> Bool {
        return (getCredit(for: subject) != nil)
    }
}
pCredits.hasCredit(for: "Programming 101")
//: Due to structures being a value type all properties of a structure are considered to be constant inside of its methods.
//:
//: `mutating` - allows methods to modify structure's properties
extension PrivateCredits {
    mutating func setCredit(for subject:String, to value: Int) -> Int? {
        return credits.updateValue(value, forKey: subject)
    }
 
    mutating func removeCredit(for subject: String) -> Int? {
        return credits.removeValue(forKey: subject)
    }
}
pCredits.setCredit(for: "TestSubject", to: 89)
pCredits.removeCredit(for: "TestSubject")
//: ### Getters, Setters and Subsripts
extension PrivateCredits {
    var average: Float {
        return credits.count == 0 ? 0 : Float(credits.values.reduce(0,{$0+$1})) / Float(credits.count)
    }
    var values: [String:Int] {
        get { return credits }
        set { credits = newValue }
    }
 
    subscript (subject: String) -> Int? {
        get { return getCredit(for: subject) }
        set {
            if let value = newValue {
                setCredit(for: subject, to: value)
            }
            else {
                removeCredit(for: subject)
            }
        }
    }
}
 
pCredits["Programming 101"] = 89
pCredits["Calculus"] = 80
pCredits["English"] = 85
 
print(pCredits.student.name, "\(pCredits.student.course).\(pCredits.student.group)")

for (subject,value) in pCredits.values {
    print(subject, ":", value)
}
//: ****
//: [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
