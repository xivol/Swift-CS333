import UIKit
import PlaygroundSupport

let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))

for i in 1...5 {
    let col = UIStackView(frame: CGRect(x: 0, y: 0, width: 50, height: 250))
    col.distribution = .fillEqually
    col.axis = .vertical
    for j in 1...5 {
        let subview = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        subview.backgroundColor = UIColor(displayP3Red: 0.2 * CGFloat(i), green: 0.2 * CGFloat(j), blue: 0.2 * CGFloat((i + j)), alpha: 1)
        col.addArrangedSubview(subview)
    }
    stackView.addArrangedSubview(col)
}
stackView.distribution = .fillEqually
stackView.axis = .horizontal

PlaygroundPage.current.liveView = stackView
