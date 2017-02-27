import UIKit
import PlaygroundSupport

class Handler {
    let message: String!
    let label: UILabel!
    @objc func buttonTouched() {
        label.text = message
    }
    
    init(with message: String, for label: UILabel){
        self.message = message
        self.label = label
    }
}

let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
containerView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)

let displayLabel = UILabel(frame: CGRect(x: 10, y: 200, width: 230, height: 40))
displayLabel.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
displayLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
displayLabel.textAlignment = .center
containerView.addSubview(displayLabel)

let button = UIButton(type: .system)
button.frame =  CGRect(x: 0, y: 0, width: 250, height: 50)
button.setTitle("Touch Me!", for: .normal)
button.setTitleColor(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), for: .normal)
button.titleLabel?.font = UIFont(name: "Chalkduster", size: 16)

let buttonH = Handler(with:"Again!", for: displayLabel)
button.addTarget(buttonH, action: #selector(Handler.buttonTouched), for: .touchUpInside)

containerView.addSubview(button)

let details = UIButton(type: .detailDisclosure)
details.frame.origin = CGPoint(x: 110, y: 70)
details.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)

let detailsH = Handler(with:"More!", for: displayLabel)
details.addTarget(detailsH, action: #selector(Handler.buttonTouched), for: .touchUpInside)

containerView.addSubview(details)

let custom = UIButton(frame: CGRect(x: 100, y: 120, width: 50, height: 50))
custom.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
custom.setTitle("Stop", for: .normal)
custom.setTitle("!!!", for: .highlighted)
custom.layer.cornerRadius = custom.bounds.width / 2

let customH = Handler(with:"Stop touching!", for: displayLabel)
custom.addTarget(customH, action: #selector(Handler.buttonTouched), for: .touchUpInside)

containerView.addSubview(custom)

PlaygroundPage.current.liveView = containerView
