/*:
 ## Optionals
 [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
 ****
 */
import Foundation
var helloString: String? = nil
type(of: helloString)

helloString = "Hello, Optional!"
//: ### Optional Initialisation
//: - `nil`
//: - Wrapped value
//:
//: Values can be wrapped into an opional type
var optInt = Int?(4)  // Int?(4)
// optInt = nil

if optInt == nil {
    "empty"
}
else {
    optInt
}
//: Some methods return optionals in case of a failure:
let stringPi = "3.1415926535897932"
let pi = Double(stringPi)
type(of: pi)
//: ### Conditional Unwrapping
let conditionalThree = pi?.rounded()
type(of: conditionalThree)

helloString = nil
let conditionalLowerString = helloString?.lowercased()
type(of: conditionalLowerString)
//: ### Optional Binding
if let boundPi = Double(stringPi) {
    "rounded pi is \(boundPi.rounded())"
}

if let str = helloString {
    str.lowercased()
} else {
    "empty string"
}
//: Guarded optional
guard let guardedPi = Double(stringPi)
else {
    fatalError("pi is nil")
}
type(of: guardedPi)
//: ### Forced Unwrapping
let forcedThree = pi!.rounded()
type(of: forcedThree)

//let forcedLowerString = helloString!.lowercased()
//type(of: forcedLowerString)

//: Forcedly Unwrapped Optional
var forcedPi: Double! = nil
forcedPi = Double(stringPi)

let threeFromForcedPi = forcedPi.rounded()

//: Optional Chaining
helloString = "Hello, Playground"

let chainedIndexOfSubstr = helloString?.range(of: "Hello")?.lowerBound
let chainedBase64 = helloString?.data(using: .utf8)?.base64EncodedString()
//: [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
