/*:
 ## Sets
 [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
 ****
 */
import Foundation
//: Init empty
var letters = Set<Character>()

let alphabet = "abcdefghijklmnopqrstuvwxyz"
for c in alphabet.characters {
    letters.insert(c)
}
//: Init from sequence
var lorem = Set<Character>("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.".characters)

for c in alphabet.characters {
    lorem.remove(c)
}
lorem

let digits = Set<Character>("1234567890".characters)
let alphanum = letters.union(digits)

digits.union(letters) == alphanum

//: ### Membership
letters.isSubset(of: alphanum)
letters.isStrictSubset(of: alphanum)

letters.isSubset(of: letters)
letters.isStrictSubset(of: letters)

digits.isDisjoint(with: letters)

alphanum.contains("9")
alphanum.isSuperset(of: "0x2a".characters)
//: ### Set Operations
var animals: Set<Character> = ["🐰","🦊","🐻","🐼","🐹"]
animals.intersection("🐰🐱🐶🐻🐙".characters)
animals.symmetricDifference("🐰🐱🐶🐻🐙".characters)
animals.subtracting("🐰🐱🐶🐻🐙".characters)
animals.union("🐰🐱🐶🐻🐙".characters)
//: ****
//:  [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
