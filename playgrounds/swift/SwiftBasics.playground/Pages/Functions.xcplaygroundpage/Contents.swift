/*:
 ## Functions
 [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
 ****
 */
func printMeSomething() {
    print("Something!")
}

printMeSomething()

func giveMeSomething() -> String {
    return "Something!"
}

giveMeSomething()
//: ### Parameters
//: Each function parameter has both an **argument label** and a **parameter name**.
func square(of x: Int) -> Int {
    return x * x
}

square(of: 5)
//: If you don’t want an argument label for a parameter, write an underscore `_` instead of an explicit argument label for that parameter.
func sqr(_ x: Int) -> Int {
    return x * x
}

sqr(12)
//: Function parameters are constants by default.  If you want a function to modify a parameter’s value, define that parameter as an in-out parameter instead.
func sort(_ a: inout Int, _ b: inout Int) {
    if a > b {
        (a, b) = (b, a)
    }
}

var a = 13, b = 8
sort( &a, &b)
a
b
//: You can use a tuple type as the return type for a function to return multiple values as part of one compound return value.
func minmax(_ a: Int, _ b:Int) -> (Int, Int) {
    return a > b ? (b, a) : (a, b)
}

let (min, max) = minmax(181, 11)
min
max
//: ### Functional type
let transform: (Int) -> Int = square
for i in 1...10 {
    transform(i)
}

func calc(_ fun: (Int) -> Int, arg: Int) -> Int {
    return fun(arg)
}

calc(sqr, arg: 5)
//: You can also define function inside the body of another functions, known as nested functions.
func operation(_ c: Character) -> (Int,Int) -> Int {
    func add( a: Int, b: Int) -> Int {
        return a + b
    }
    func sub( a: Int, b: Int) -> Int {
        return a - b
    }
    func mul( a: Int, b: Int) -> Int {
        return a * b
    }
    func div( a: Int, b: Int) -> Int {
        return a / b
    }
    switch c {
    case "*":
        return mul
    case "/":
        return div
    case "-":
        return sub
    default:
        return add
    }
}

let op = operation("+")
 op(1, 2)
//: ### Closures
var modulus = {
    (a: Int, b: Int) in
    return a % b
}
modulus(15,4)
//: Argument type inferrence.
type(of: modulus)
modulus = { a, b in return a % b }
modulus(15,4)
//: Closures implicitly return result of the last operator.
modulus = { a, b in a % b }
modulus(15,4)
//: Shorthand parameter names.
modulus = { $0 % $1 }
modulus(15,4)
//: ****
//: [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
