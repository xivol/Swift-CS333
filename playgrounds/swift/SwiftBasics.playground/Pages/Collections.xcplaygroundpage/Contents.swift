/*:
 ## Collections
 [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
 ****
 */
//: ### Strings
var str = "Hello, playground"
str += "!"

for c in str.characters {
    c
}
//: _String Views_
let utf16Rep = "Ё"
utf16Rep.utf8.count
utf16Rep.utf16.count
utf16Rep.unicodeScalars.count

let utf32Rep = "😀"
utf32Rep.utf8.count
utf32Rep.utf16.count
utf32Rep.unicodeScalars.count

let utf64Rep = "👍🏻👍🏼👍🏿"
utf64Rep.unicodeScalars.count
for uScalar in utf64Rep.unicodeScalars {
    print(uScalar)
}
//: ****
//: [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
