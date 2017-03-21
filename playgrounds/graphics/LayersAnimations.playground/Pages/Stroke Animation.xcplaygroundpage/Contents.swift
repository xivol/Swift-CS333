import UIKit
import PlaygroundSupport

var view = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))

view.layer.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1).cgColor

var circle = CAShapeLayer()
let rect = CGRect(x: view.bounds.width / 3,
                  y: view.bounds.height / 3,
                  width: view.bounds.width / 3,
                  height: view.bounds.height / 3)
circle.path = CGPath(ellipseIn: rect, transform: nil)

circle.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
circle.lineWidth = view.bounds.width / 3

view.layer.addSublayer(circle)

circle.strokeStart = 0
let start = CABasicAnimation(keyPath: "strokeStart")
start.toValue = 0.5

circle.strokeEnd = 1
let end = CABasicAnimation(keyPath: "strokeEnd")
end.toValue = 0.5

let groupAnimation = CAAnimationGroup()
groupAnimation.animations = [start,end]
groupAnimation.duration = 3
groupAnimation.autoreverses = true
groupAnimation.repeatCount = 100
circle.add(groupAnimation, forKey: "stroke")

PlaygroundPage.current.liveView = view

