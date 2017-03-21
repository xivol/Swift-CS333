//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

var view = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 500))

let layer = CAGradientLayer()
layer.frame = view.bounds

layer.colors = [#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1).cgColor, #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).cgColor, #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1).cgColor, #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1).cgColor, #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor, #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1).cgColor, #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1).cgColor]

//layer.locations = [0.0, 0.2, 0.4, 0.5, 0.6, 0.8, 1.0]

layer.startPoint = CGPoint(x: 0.5, y: 0.0)
layer.endPoint = CGPoint(x: 0.5, y: 1.0)

view.layer.addSublayer(layer)

PlaygroundPage.current.liveView = view
