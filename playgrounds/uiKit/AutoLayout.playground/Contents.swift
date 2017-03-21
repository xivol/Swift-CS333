//: # Auto Layout Constraints
//: A constraint defines a relationship between two user interface objects that must be satisfied by the constraint-based layout system. Each constraint is a linear equation with the following format:
//:
//: `view1.attribute1 = multiplier × view2.attribute2 + constant`
//:
//: [Auto Layout Programming Guide](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/AutolayoutPG/)
import UIKit
import PlaygroundSupport

let controller = UIViewController()
PlaygroundPage.current.liveView = controller

for _ in 0...6 {
    let view = UIView()
    controller.view.addSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false
}

let subviews = controller.view.subviews

subviews[0].backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
subviews[1].backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
subviews[2].backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
subviews[3].backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
subviews[4].backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
subviews[5].backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
subviews[6].backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)

// Subview 0 White

NSLayoutConstraint(item: subviews[0], attribute: NSLayoutAttribute.top, relatedBy: .equal,
                   toItem: controller.view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 10).isActive = true
NSLayoutConstraint(item: subviews[0], attribute: NSLayoutAttribute.leading, relatedBy: .equal,
                   toItem: controller.view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 10).isActive = true
NSLayoutConstraint(item: subviews[0], attribute: NSLayoutAttribute.trailing, relatedBy: .equal,
                   toItem: controller.view, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -10).isActive = true
NSLayoutConstraint(item: subviews[0], attribute: NSLayoutAttribute.bottom, relatedBy: .equal,
                   toItem: controller.view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: -10).isActive = true

// Subview 1 Orange

let sub1Constraints = [
    subviews[1].topAnchor.constraint(equalTo: subviews[0].topAnchor, constant: 10),
    subviews[1].leadingAnchor.constraint(equalTo: subviews[0].leadingAnchor, constant: 10),
    subviews[1].widthAnchor.constraint(equalTo: subviews[0].widthAnchor, multiplier: 0.5, constant: -15),
    subviews[1].heightAnchor.constraint(equalTo: subviews[0].heightAnchor, multiplier: 0.2, constant: -10)
]
NSLayoutConstraint.activate(sub1Constraints)

// Subview 2 Red

NSLayoutConstraint.activate([
    subviews[2].topAnchor.constraint(equalTo: subviews[1].topAnchor),
    subviews[2].leadingAnchor.constraint(equalTo: subviews[1].trailingAnchor, constant: 10),
    subviews[2].widthAnchor.constraint(equalTo: subviews[1].widthAnchor),
    subviews[2].heightAnchor.constraint(equalTo: subviews[1].heightAnchor)
    ])

// Subview 3 Magenta

NSLayoutConstraint.activate([
    subviews[3].topAnchor.constraint(equalTo: subviews[1].bottomAnchor, constant: 10),
    subviews[3].leadingAnchor.constraint(equalTo: subviews[1].leadingAnchor),
    subviews[3].trailingAnchor.constraint(equalTo: subviews[2].trailingAnchor),
    subviews[3].heightAnchor.constraint(equalTo: subviews[3].widthAnchor),
    
// Subview 4 Pink
    
    subviews[4].centerXAnchor.constraint(equalTo: subviews[3].centerXAnchor),
    subviews[4].centerYAnchor.constraint(equalTo: subviews[3].centerYAnchor),
    subviews[4].widthAnchor.constraint(equalTo: subviews[3].widthAnchor, multiplier: 0.5),
    subviews[4].heightAnchor.constraint(equalTo: subviews[3].heightAnchor, multiplier: 0.5)
    ])

// Subview 5 Blue

NSLayoutConstraint.activate([
    subviews[5].topAnchor.constraint(equalTo: subviews[3].bottomAnchor, constant: 10),
    subviews[5].bottomAnchor.constraint(equalTo: subviews[0].bottomAnchor, constant: -10),
    subviews[5].widthAnchor.constraint(equalTo: subviews[0].widthAnchor, multiplier: 0.3)
    ])

// Subview 0 width should be recalculated before activating next constraints
controller.view.layoutSubviews()

NSLayoutConstraint.activate([
    subviews[5].centerXAnchor.constraint(equalTo: subviews[0].centerXAnchor, constant: -subviews[0].bounds.width / 4)
    ])

// Subviews 6 Green

NSLayoutConstraint.activate([
    subviews[6].centerYAnchor.constraint(equalTo: subviews[5].centerYAnchor),
    subviews[6].centerXAnchor.constraint(equalTo: subviews[0].centerXAnchor, constant: subviews[0].bounds.width / 4),
    
    subviews[6].heightAnchor.constraint(equalTo: subviews[5].widthAnchor),
    subviews[6].widthAnchor.constraint(equalTo: subviews[5].heightAnchor)
])

// Removing/Deactivating constraints
let constraints = controller.view.constraints.filter {
    return $0.firstItem === subviews[6] || $0.secondItem === subviews[6]
}

NSLayoutConstraint.deactivate(constraints)
