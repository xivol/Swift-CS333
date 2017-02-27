//: # UIView
import UIKit
import PlaygroundSupport

let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))

let subviews = [
    UIView(frame: CGRect(x: 10,  y: 10,  width: 110, height: 110)),
    UIView(frame: CGRect(x: 10,  y: 130, width: 110, height: 110)),
    UIView(frame: CGRect(x: 130, y: 10,  width: 110, height: 110)),
    UIView(frame: CGRect(x: 130, y: 130, width: 110, height: 110)),
]
subviews.forEach {containerView.addSubview($0)}

subviews[0].backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
subviews[1].backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
subviews[2].backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
subviews[3].backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
containerView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)

let circle = UIView(frame: CGRect(x: 100,  y: 100,  width: 50, height: 50))
circle.layer.cornerRadius = circle.bounds.width / 2
circle.layer.shadowRadius = 5
circle.layer.shadowOpacity = 0.8
circle.layer.shadowOffset = CGSize.zero
circle.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
circle.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).withAlphaComponent(0.7)
containerView.addSubview(circle)

PlaygroundPage.current.liveView = containerView
