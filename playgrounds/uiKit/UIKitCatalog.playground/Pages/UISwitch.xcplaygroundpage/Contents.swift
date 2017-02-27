import UIKit
import PlaygroundSupport

class Handler {
    let view: UIView!
    @objc func buttonTouched(sender: UISwitch) {
        UIView.animate(withDuration: 0.2){
            if sender.isOn {
                self.view.backgroundColor = sender.tintColor
            } else {
                self.view.backgroundColor = UIColor.clear
            }
        }
    }
    
    init(with view: UIView){
        self.view = view
    }
}

let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
containerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

let size = UISwitch().bounds.size
let rows = Int(floor(containerView.bounds.width / size.width))
let cols = Int(floor(containerView.bounds.height / size.height)) - 1
let offset = CGPoint(x: (containerView.bounds.width - CGFloat(rows) * size.width) / CGFloat(rows),
                     y: (containerView.bounds.height - CGFloat(cols) * size.height) / CGFloat(cols))

var handlers = [Handler]()

for i in 0..<(rows * cols) {
    let swtch = UISwitch(frame: CGRect(origin: CGPoint(x: CGFloat(i%rows) * (size.width + offset.x) + offset.x / 2, y: CGFloat(i/rows) * (size.height + offset.y) + offset.y / 2), size: size))
    swtch.tintColor = UIColor(hue: CGFloat(drand48()), saturation: 1, brightness: 1, alpha: 1)
    swtch.onTintColor = swtch.tintColor
    
    let displayView = UIView(frame: CGRect(x: swtch.frame.origin.x-10, y: swtch.frame.origin.y-5,
                                           width: 10, height: 10))
    displayView.layer.cornerRadius = displayView.bounds.width / 2
    
    let handler = Handler(with: displayView)
    handlers.append(handler)
    containerView.addSubview(displayView)
    
    swtch.addTarget(handler, action: #selector(Handler.buttonTouched(sender:)), for: .valueChanged)
    containerView.addSubview(swtch)
}


PlaygroundPage.current.liveView = containerView
