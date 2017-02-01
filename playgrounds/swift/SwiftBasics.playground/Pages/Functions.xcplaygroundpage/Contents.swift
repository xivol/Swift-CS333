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

print(giveMeSomething())
//: ### Parameters
//: _Each function parameter has both an **argument label** and a **parameter name**._

func square(of x: Int) -> Int {
    return x * x
}

square(of: 5)
//: _If you don’t want an argument label for a parameter, write an underscore `_` instead of an explicit argument label for that parameter._
func sqr(_ x: Int) -> Int {
    return x * x
}

sqr(12)
//: _Function parameters are constants by default.  If you want a function to modify a parameter’s value, define that parameter as an in-out parameter instead._
func sort(_ a: inout Int, _ b: inout Int) {
    if a > b {
        (a, b) = (b, a)
    }
}

var a = 13, b = 8
sort( &a, &b)
print(a, b)

//: _You can use a tuple type as the return type for a function to return multiple values as part of one compound return value._
func minmax(_ a: Int, _ b:Int) -> (min: Int, max: Int) {
    return a > b ? (b, a) : (a, b)
}

let (min, max) = minmax(181, 11)
print(min, max)
//: ### Functional type
let transform: (Int) -> Int = square
for i in 1...10 {
    print(transform(i), separator: "", terminator: " ")
}
print()

func calc(_ fun: (Int) -> Int, arg: Int) -> Int {
    return fun(arg)
}

print(calc(sqr, arg: 5))

//: _You can also define functions inside the bodies of other functions, known as nested functions._
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
print( op(1, 2) )
//: ### Closures
var modulus = { (a: Int, b: Int) in return a % b }
print( modulus(15,4) )
//: _Argument type inferrence._
modulus = { a, b in return a % b }
print( modulus(15,4) )
//: _Closures implicitly return result of last operatior._
modulus = { a, b in a % b }
print( modulus(15,4) )
//: _Shorthand parameter names_
modulus = { $0 % $1 }
print( modulus(15,4) )
//: [⬅️](@previous) · [⬆️](TableOfContents) · [➡️](@next)
