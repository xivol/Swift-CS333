//: # UIStackView
//:The UIStackView class provides a streamlined interface for laying out a collection of views in either a column or a row.
//:
//: [UIStackView API Reference](https://developer.apple.com/reference/uikit/uistackview)
import UIKit
import PlaygroundSupport

let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))

for i in 1...5 {
    let column = UIStackView(frame: CGRect(x: 0, y: 0, width: 50, height: 250))
    for j in 1...5 {
        let subview = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        subview.backgroundColor = UIColor(displayP3Red: 0.2 * CGFloat(i), green: 0.2 * CGFloat(j), blue: 0.2 * CGFloat(i + j), alpha: 1)
        column.addArrangedSubview(subview)
    }
    
    column.distribution = .fillEqually
    column.axis = .vertical
    column.spacing = 1
    stackView.addArrangedSubview(column)
}
stackView.distribution = .fillEqually
stackView.axis = .horizontal
stackView.spacing = 1

PlaygroundPage.current.liveView = stackView
