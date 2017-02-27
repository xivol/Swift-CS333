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
