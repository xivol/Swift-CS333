import UIKit
import PlaygroundSupport

class Controller {
    let label: UILabel!
    @objc func valueChanged(sender: UIStepper) {
        label.textColor = sender.tintColor
        label.backgroundColor = sender.backgroundColor
        label.text = "\(sender.value)"
    }
    
    init(with label: UILabel){
        self.label = label
    }
}

let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 200))
containerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

let displayLabel = UILabel(frame: CGRect(x: 0, y: 150, width: 250, height: 40))
displayLabel.textAlignment = .center
containerView.addSubview(displayLabel)

let size = UIStepper().bounds.size
let origin = CGPoint(x: (containerView.bounds.width - size.width) / 2, y: size.height)

let stepper = UIStepper(frame: CGRect(origin: origin, size: size))
stepper.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
stepper.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
stepper.layer.cornerRadius = 5
stepper.maximumValue = 10
stepper.stepValue = 0.5

let controller = Controller(with: displayLabel)
stepper.addTarget(controller, action: #selector(Controller.valueChanged(sender:)), for: .valueChanged)
containerView.addSubview(stepper)

let imageSteps = UIStepper(frame: CGRect(origin: CGPoint(x: origin.x, y: size.height * 3), size: size))
imageSteps.backgroundColor = .white
imageSteps.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
imageSteps.setIncrementImage("🔺".image, for: .normal)
imageSteps.setDecrementImage("🔻".image, for: .normal)

imageSteps.addTarget(controller, action: #selector(Controller.valueChanged(sender:)), for: .valueChanged)
containerView.addSubview(imageSteps)

PlaygroundPage.current.liveView = containerView
