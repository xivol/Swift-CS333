import Foundation

public class Player {
    let name: String
    var position: Int = 0
    
    public init(name: String) {
        self.name = name
    }
    
    func roll(_ dice: Dice) -> Int {
        return dice.roll()
    }
}
