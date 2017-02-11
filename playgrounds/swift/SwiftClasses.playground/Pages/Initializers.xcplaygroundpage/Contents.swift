//: ## Initializers
//: [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
//: ****
//: ### Default Initializers
//: Classes and structures will have a default initializer if every stored property is initialized explicitly
struct Point {
    var x = 0.0, y = 0.0
}
let zero = Point()
//: Structures also have a memeber-wise initializer
struct Size {
    var width = 0, height = 0
}
let square = Size(width: 100, height: 100)
//: Classes don't have a memeber-wise initializer
class Rectangle {
    var origin = Point()
    var size = Size()
    
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
}
let rect = Rectangle(origin: zero, size: square)
//: ### Designated and Convenience Initializers
//: Classes have two types of initializers:
//: - designated — fully initializes every property of the class
//: - convenience — covers specific use case of initializetion parameters
extension Rectangle {
    // Convenience initializers can be declared in extencions
    convenience init(center: Point, size: Size) {
        let originX = center.x - Double(size.width) / 2.0
        let originY = center.y - Double(size.height) / 2.0
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
//: ### Initializers and Class Heirarchy
//: If no designated initializers are declared, designated initializers of the superclass are inherited
class DefaultTextBox: Rectangle {
    var text = ""
}
let def = DefaultTextBox(center: zero, size: square)
def.text = "Hello!"
//: Any designated initializer must call superclass initializer
class TextBox: Rectangle {
    var text = ""
    
    init(text: String, origin: Point, size: Size) {
        self.text = text;
        super.init(origin: origin, size: size)
    }
}
//: Convenience initializers can not call super class initializer. They must call another initializer from the same class instead
extension TextBox {
    convenience init(text: String, center: Point, size: Size) {
        let originX = center.x - Double(size.width) / 2
        let originY = center.y - Double(size.height) / 2
        self.init(text: text, origin: Point(x: originX, y: originY),
                  size: size)
    }
}
//: ### Required Initializers
//: You can require all subclasses to implement a specific initializer
class Polygon {
    var points = [Point]()
    required init() {}
}
class RegularPolygon: Polygon {
    required init() {}
}
class Triangle: Polygon {
    required init() {}
}
//: ### Deinitializers
class Star: Polygon {
    deinit {
        print("I was a Star!")
    }
}
//: [Table of Contents](TableOfContents) · [Previous](@previous) · [Next](@next)
//: ****
