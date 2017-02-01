/*:
 ## Strings
 [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
 ****
 */
import Foundation

var hello = "Hello, playground"
hello += "!"
for c in hello.characters { c }
//: ### String Initialization
let pi = 3.141592653589793

let inerpolated = "PI == \(pi)"
let piString = String(pi)
let formatedString = String(format: "%#x, %d", 255, 0x2a)

/*:
 ### String Views
 */
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
    Character(uScalar)
}
/*:
 ### String Indices
 */
var abc = "abcdefghijklmnopqrstuvwxyz"
guard let start = abc.index(abc.startIndex, offsetBy: 10, limitedBy: abc.endIndex),
     let end = abc.index(abc.endIndex, offsetBy: -10, limitedBy: abc.startIndex)
else {
        fatalError("Wrong offset!")
}
abc[start...end]
//:
abc.insert("|", at: start)
abc.insert("|", at: end)
abc[start...end]
abc.removeSubrange(start...end)
//:
let distance = abc.distance(from: start, to: end)
let insertion = String(repeating: "|", count: distance)
abc.insert(contentsOf: insertion.characters, at: start)
//:
let insertionEnd = abc.index(start, offsetBy: insertion.characters.count)
let replacement = "HELLO"
abc.replaceSubrange(start..<insertionEnd, with: replacement.characters)
//:
if let repRange = abc.range(of: replacement) {
    abc[repRange]
}
//: Indices and string views
let emojiNumbers = "0️⃣1️⃣2️⃣3️⃣4️⃣5️⃣6️⃣7️⃣8️⃣9️⃣🔟"
let indexOfFive = emojiNumbers.characters.index(of: "5️⃣")!
emojiNumbers[indexOfFive..<emojiNumbers.endIndex]

let utf8IndexOfFive = indexOfFive.samePosition(in: emojiNumbers.utf8)
emojiNumbers.utf8[emojiNumbers.utf8.startIndex..<utf8IndexOfFive]

//: ### Split String
let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

for word in text.components(separatedBy: " "){
    word.capitalized
}
//: ****
//: [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
