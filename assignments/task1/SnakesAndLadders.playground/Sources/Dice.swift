import Foundation

public class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    
    public init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    
    public func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}
