import UIKit
import PlaygroundSupport

var view = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))

view.layer.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1).cgColor

let dotCount = 6

for i in 0...dotCount {
    for j in 0..<dotCount {
        let dotSize = CGSize(width: view.bounds.width / CGFloat(dotCount), height: view.bounds.width / CGFloat(dotCount))
        let originX = view.bounds.origin.x + (0.25 + CGFloat(i) - CGFloat(j % 2) / 2) * dotSize.width
        let originY = view.bounds.origin.y + (0.25 + CGFloat(j)) * dotSize.height
        
        let dot = CAShapeLayer()
        dot.path = CGPath(ellipseIn: CGRect(x: originX, y: originY, width: dotSize.width / 2, height: dotSize.height / 2), transform: nil)
        
        dot.fillColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).cgColor
        dot.strokeColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1).cgColor
        
        view.layer.addSublayer(dot)
    }
}

let star = CAShapeLayer()
let starPath = UIBezierPath(starWithNumberOfPoints: 5, centeredAt: view.center, innerRadius: view.bounds.width / 4, outerRadius: view.bounds.width / 2)

star.path = starPath.cgPath
view.layer.mask = star

PlaygroundPage.current.liveView = view
