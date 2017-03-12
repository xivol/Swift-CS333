import UIKit
import PlaygroundSupport

var view = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))

view.layer.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1).cgColor

var star = CAShapeLayer()
star.path = UIBezierPath(starWithNumberOfPoints: 5, centeredAt: view.center, innerRadius: view.bounds.width / 6, outerRadius: view.bounds.width / 3).cgPath

star.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
star.fillColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1).cgColor
view.layer.addSublayer(star)

let keyframeAnimation = CAKeyframeAnimation(keyPath: "path")
keyframeAnimation.values = []
for points in 5...10 {
    let starPath = UIBezierPath(starWithNumberOfPoints: points, centeredAt: view.center, innerRadius: view.bounds.width / 6, outerRadius: view.bounds.width / 3)
    keyframeAnimation.values?.append(starPath.cgPath)
}

keyframeAnimation.duration = 5
//keyframeAnimation.keyTimes = [0, 0.1, 0.2, 0.5, 0.7, 1]
keyframeAnimation.autoreverses = true

star.add(keyframeAnimation, forKey: "points")
PlaygroundPage.current.liveView = view