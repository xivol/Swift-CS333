import UIKit
import PlaygroundSupport

var view = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))

view.layer.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1).cgColor

var star = CAShapeLayer()

let starPath = UIBezierPath(starWithNumberOfPoints: 5, centeredAt: view.center, innerRadius: view.bounds.width / 6, outerRadius: view.bounds.width / 3)

star.path = starPath.cgPath

star.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
star.fillColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1).cgColor
view.layer.addSublayer(star)

let starAnimation = CABasicAnimation(keyPath: "path")
starAnimation.fromValue = UIBezierPath(roundedRect: view.layer.bounds, cornerRadius: 20).cgPath
starAnimation.fillMode = kCAFillModeBoth
starAnimation.duration = 5

let fillAnimation = CABasicAnimation(keyPath: "fillColor")
fillAnimation.fromValue = UIColor.clear.cgColor

fillAnimation.beginTime = 4.8
fillAnimation.duration = 1
fillAnimation.fillMode = kCAFillModeBoth

let groupAnimation = CAAnimationGroup()
groupAnimation.animations = [starAnimation,fillAnimation]
groupAnimation.duration = 6

star.add(groupAnimation, forKey: "stroke and fill")
PlaygroundPage.current.liveView = view
