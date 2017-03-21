import UIKit
import PlaygroundSupport

var view = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))

let patternDepth = 8
let colorStep = 1 / CGFloat(patternDepth)
var width = view.bounds.width

for i in 0...patternDepth {
    let offset = (view.bounds.width - width) / 2
    let squareFrame = CGRect(x: view.bounds.origin.x + offset,
                             y: view.bounds.origin.y + offset,
                             width: width, height: width)
    var square = CALayer()
    square.frame = squareFrame
    
    square.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
    square.borderWidth = 1
    
    square.backgroundColor = UIColor(hue: colorStep * CGFloat(i), saturation: 0.8, brightness: 0.8, alpha: 1).cgColor
    
    square.transform = CATransform3DMakeAffineTransform(CGAffineTransform(rotationAngle: CGFloat(M_PI_4 * Double(i))))
 
    view.layer.addSublayer(square)
    
    width /= CGFloat(sqrt(2))
}

PlaygroundPage.current.liveView = view