//: # UIView
//: The `UIView` class defines a rectangular area on the screen and the interfaces for managing the content in that area.
//:
//: [UIView API Refernce](https://developer.apple.com/reference/uikit/uiview)
import UIKit
import PlaygroundSupport

//: ### View Frame
let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))

let subviews = [
    UIView(frame: CGRect(x: 10,  y: 10,  width: 110, height: 110)),
    UIView(frame: CGRect(x: 10,  y: 130, width: 110, height: 110)),
    UIView(frame: CGRect(x: 130, y: 10,  width: 110, height: 110)),
    UIView(frame: CGRect(x: 130, y: 130, width: 110, height: 110)),
]
subviews.forEach { containerView.addSubview($0) }

subviews[0].backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
subviews[1].backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
subviews[2].backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
subviews[3].backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
containerView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)

//: ### Subview Order
let circle = UIView(frame: CGRect(x: 75,  y: 75,  width: 100, height: 100))
circle.layer.cornerRadius = circle.bounds.width / 2
circle.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

containerView.insertSubview(circle, at: 1)

containerView.sendSubview(toBack: subviews[3])
//: ### View Bounds
subviews[1].bounds = CGRect(x: -10, y: -10, width: 120, height: 120)
subviews[2].bounds.size = CGSize(width: 90, height: 90)
// Populate view with subviews
let dotCount = 6
for i in 0..<dotCount + 1 {
    for j in 0..<dotCount {
        let dotSize = CGSize(width: subviews[1].bounds.width / CGFloat(dotCount), height: subviews[1].bounds.width / CGFloat(dotCount))
        let originX = subviews[1].bounds.origin.x + (0.25 + CGFloat(i) - CGFloat(j % 2) / 2) * dotSize.width
        let originY = subviews[1].bounds.origin.y + (0.25 + CGFloat(j)) * dotSize.height
        
        let dot = UIView(frame: CGRect(x: originX, y: originY, width: dotSize.width / 2, height: dotSize.height / 2))
        dot.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        dot.layer.cornerRadius = dot.bounds.width / 2
        subviews[1].addSubview(dot)
    }
}
//: Set bounds to clip subviews
subviews[1].clipsToBounds = true

//: ### View Masks
let patternDepth = 4
// Populate view with subviews
for i in 1...patternDepth {
    let width = subviews[3].bounds.width / CGFloat(pow(sqrt(2), Double(i)))
    let offset = (subviews[3].bounds.width - width) / 2
    let squareFrame = CGRect(x: subviews[3].bounds.origin.x + offset,
                             y: subviews[3].bounds.origin.y + offset,
                             width: width, height: width)
    let square = UIView(frame: squareFrame)
    square.backgroundColor = i % 2 == 0 ? #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1) : #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
    // View transform
    square.transform = CGAffineTransform.init(rotationAngle: CGFloat(M_PI_4 * Double(i)))
    subviews[3].addSubview(square)
}
//: Create mask
let circleMask = UIView(frame: CGRect(origin: CGPoint.zero, size: subviews[3].frame.size))
circleMask.layer.cornerRadius = circleMask.bounds.width / 2
//: Without any content view is transparent - it cannot be used as mask. By setting its color we allow it to be used as a mask
circleMask.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
subviews[3].mask = circleMask

PlaygroundPage.current.liveView = containerView
