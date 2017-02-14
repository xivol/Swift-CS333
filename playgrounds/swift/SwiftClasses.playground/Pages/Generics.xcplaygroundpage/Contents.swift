//: ## Generics
//: [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
//: ****
//: ### Generic Functions
func generic_swap<T> (_ a:inout T, _ b:inout T) {
    (a,b) = (b,a)
}
var i = 32, j = 24

generic_swap(&i, &j)
(i,j)
//: ### Protocol Comformance
func generic_max<T: Comparable>(_ a: T, _ b: T) -> T {
    return a > b ? a : b
}

generic_max(i, j)
//: ### Generic Classes
struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ value: Element) {
        items.append(value)
    }
    mutating func pop() -> Element? {
        if let value = items.last {
            items.removeLast()
            return value
        }
        return nil
    }
}

var s = Stack<Int>()
s.push(3)
s.push(5)
s.push(8)
//: ### Extension of Generic Class
extension Stack: CustomStringConvertible {
    var description: String {
        return "\(Element.self):\(items)"
    }
}
s
//: ### Protocol Conformance
struct ExclusiveStack<Element> where Element: Hashable {
    var items = [Element]()
    mutating func push(_ value: Element) -> Bool {
        let uniq = Set<Element>(items)
        if uniq.contains(value) {
            return false
        } else {
            items.append(value)
            return true
        }
    }
    mutating func pop() -> Element? {
        if let value = items.last {
            items.removeLast()
            return value
        }
        return nil
    }
}

extension ExclusiveStack: CustomStringConvertible {
    var description: String {
        return "\(items)"
    }
}

var es = ExclusiveStack<Int>()
es.push(3)
es.push(5)
es.push(8)
es.push(3)
es.push(5)
es.push(8)
es
//: ****
//: [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
