import UIKit
import PlaygroundSupport

class Controller: NSObject, UITextViewDelegate {
    let label: UILabel!
    @objc func editingDidEnd(sender: UITextField) {
        if let newValue = sender.text {
            label.text = newValue
        }
    }
    
    init(with label: UILabel){
        self.label = label
    }
    
    // MARK: UITextViewDelegate
    
    func textViewDidEndEditing(_ textView: UITextView) {
        label.text = textView.text
    }
}

let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
containerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 250, height: 30))
textField.borderStyle = .roundedRect
textField.placeholder = "username"

containerView.addSubview(textField)

let pass = UITextField(frame: CGRect(x: 0, y: 50, width: 250, height: 30))
pass.borderStyle = .line
pass.textColor = pass.tintColor
pass.placeholder = "password"

pass.isSecureTextEntry = true
pass.autocorrectionType = .no
pass.clearButtonMode = .always

containerView.addSubview(pass)

let imageBack = UITextField(frame: CGRect(x: 0, y: 100, width: 250, height: 30))
imageBack.background = #imageLiteral(resourceName: "gradient.png")
imageBack.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
imageBack.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
imageBack.textAlignment = NSTextAlignment.center
imageBack.tag = 3

containerView.addSubview(imageBack)

let textView = UITextView(frame: CGRect(x: 0, y: 150, width: 250, height: 30))
textView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
textView.textAlignment = NSTextAlignment.justified

containerView.addSubview(textView)

let displayLabel = UILabel(frame: CGRect(x: 0, y: 200, width: 250, height: 30))
displayLabel.textAlignment = .center
containerView.addSubview(displayLabel)

let controller = Controller(with: displayLabel)
textField.addTarget(controller, action: #selector(Controller.editingDidEnd(sender:)), for: .editingDidEnd)
pass.addTarget(controller, action: #selector(Controller.editingDidEnd(sender:)), for: .editingDidEnd)
imageBack.addTarget(controller, action: #selector(Controller.editingDidEnd(sender:)), for: .editingDidEnd)
textView.delegate = controller

PlaygroundPage.current.liveView = containerView