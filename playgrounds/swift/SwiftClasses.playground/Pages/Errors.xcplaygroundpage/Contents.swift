//: ## Errors
//: [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
//: ****
import Foundation

//: ### Consider an Optional
func gcd(_ a: Int, _ b: Int) -> Int? { // greatest common divisor
    guard a > 0 else { return nil }
    if b == 0 { return a }
    return gcd(b, a % b)
}
if let result = gcd(5, -5) {
    result
}
else {
    "Error"
}
//: ### Error Protocol
enum AccessDenied: Error {
    case UnknownResource(String)
    case UnauthorisedAccess(userName: String, resource: String)
    case UnregisteredUser(String)
}
//: ### Throwing an Error
class DataBase {
    var users: Set<String>
    var resources: [String : Set<String>]
    init(users: Set<String>, resources: [String:Set<String>]) {
        self.users = users
        self.resources = resources
    }
    
    func get(_ resource: String, for user: String) throws -> String {
        print("Trying to get \(resource) for \(user):")
        guard resources[resource] != nil else {
            throw AccessDenied.UnknownResource(resource)
        }
        guard users.contains(user) else {
            throw AccessDenied.UnregisteredUser(user)
        }
        guard resources[resource]!.contains(user) else {
            throw AccessDenied.UnauthorisedAccess(userName: user, resource: resource)
        }
        return resource
        
    }
    
}
let fileSystem = DataBase(users: ["Mike", "Will", "Dustin", "Lucas", "El"],
                          resources: ["theTombOfDoom" : ["Mike", "Will", "Dustin", "Lucas"],
                                      "puddingLivestream" : ["Dustin", "El"],
                                      "eggosRecipe" : ["El"]])
//: ### Cleanup
defer {
    print("And they lived happily ever after!") // defer is executed when executon leaves current scope
}
//: ### Optional Wrapping
if let game = try? fileSystem.get("theTombOfDoom", for: "Will") {
    print("The Game of \(game) has begun!")
} else {
    print("Error")
}
print("Success!")
//: ### Error Handling
do {
    let eggos = try fileSystem.get("eggosRecipe", for: "Dustin")
    
}
catch AccessDenied.UnknownResource(let resource) {
    print("Unknown Resource: \(resource)")
}
catch AccessDenied.UnauthorisedAccess {
    print("Unauthorised Access")
}
catch is AccessDenied {
    print("Access Denied")
}
catch {
    print("Unknown Error")
}
//: ### Error Propagation
func giveMeAll(for user: String) throws -> String {
    var result = ""
    for resource in fileSystem.resources.keys {
        result += try fileSystem.get(resource, for: user)
    }
    return result
}

do {
    try giveMeAll(for: "Lucas")
}
catch let error as AccessDenied {
    print(error)
}
//: ### Error Suppression
try! fileSystem.get("puddingLivestream", for: "Dustin") // ride or die approach
//: ****
//: [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
