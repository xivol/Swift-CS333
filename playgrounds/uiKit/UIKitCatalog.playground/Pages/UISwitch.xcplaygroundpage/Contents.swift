import UIKit
import PlaygroundSupport

//class Handler {
//    let message: String!
//    let label: UILabel!
//    @objc func buttonTouched() {
//        label.text = message
//    }
//    
//    init(with message: String, for label: UILabel){
//        self.message = message
//        self.label = label
//    }
//}

let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
containerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

let switches = [UISwitch]()
let number = 3
let size = CGSize(width: containerView.bounds.width / CGFloat(number),
                  height: containerView.bounds.height / CGFloat(number))
for i in 0..<(number * number) {
    let swtch = UISwitch(frame: CGRect(origin: CGPoint(x: CGFloat(i) * size.width, y: CGFloat(i/3) * size.height), size: size))
    containerView.addSubview(swtch)
}

PlaygroundPage.current.liveView = containerView
