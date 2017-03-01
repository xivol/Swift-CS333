import UIKit
import PlaygroundSupport

class Controller {
    let label: UILabel!
    let imageView: UIImageView!
    
    @objc func systemButtonTouched(sender: UIBarButtonItem) {
        imageView.image = nil
        // There is no convenient way to distinguish between system buttons
        label.text = "System button"
    }
    
    @objc func imageButtonTouched(sender: UIBarButtonItem) {
        if let fullColorImage = sender.image?.withRenderingMode(.alwaysOriginal) {
            imageView.image = fullColorImage
            label.text = ""
        }
    }
    
    @objc func fakeButtonTouched(sender: UIButton) {
        imageView.image = nil
        label.text = sender.titleLabel?.text
    }

    init(with label: UILabel){
        self.label = label
        self.imageView = UIImageView(frame: label.bounds)
        self.label.addSubview(imageView)
        imageView.contentMode = .center
    }
    
}

let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
containerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

let displayLabel = UILabel(frame: CGRect(x: 0, y: 200, width: 250, height: 50))
displayLabel.textAlignment = .center
containerView.addSubview(displayLabel)

let controller = Controller(with: displayLabel)

let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 250, height: 30))
toolbar.items = [
    UIBarButtonItem(barButtonSystemItem: .trash, target: controller, action: #selector(Controller.systemButtonTouched(sender:))),
    UIBarButtonItem(barButtonSystemItem: .bookmarks, target: controller, action: #selector(Controller.systemButtonTouched(sender:))),
    UIBarButtonItem(barButtonSystemItem: .camera, target: controller, action: #selector(Controller.systemButtonTouched(sender:))),
    UIBarButtonItem(barButtonSystemItem: .organize, target: controller, action: #selector(Controller.systemButtonTouched(sender:))),
    UIBarButtonItem(barButtonSystemItem: .action, target: controller, action: #selector(Controller.systemButtonTouched(sender:))),
    UIBarButtonItem(barButtonSystemItem: .compose, target: controller, action: #selector(Controller.systemButtonTouched(sender:))),
    UIBarButtonItem(barButtonSystemItem: .reply, target: controller, action: #selector(Controller.systemButtonTouched(sender:))),
    UIBarButtonItem(barButtonSystemItem: .search, target: controller, action: #selector(Controller.systemButtonTouched(sender:)))
    ]

containerView.addSubview(toolbar)

let custombar = UIToolbar(frame: CGRect(x: 0, y: 50, width: 250, height: 30))
custombar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
custombar.setBackgroundImage(#imageLiteral(resourceName: "gradient.png"), forToolbarPosition: .any, barMetrics: .default)

let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

let titles = ["Add", "Me", "To", "The", "Bar" ]

custombar.items = []
custombar.items?.append(space)
for title in titles {
    // UIBarButtonItem(title: title, style: UIBarButtonItemStyle.done, target: controller, action: #selector(Controller.buttonTouched(sender:)))
    // Default button has weird alignment issues!
    
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 30))
    button.setTitle(title, for: .normal)
    button.addTarget(controller, action: #selector(Controller.fakeButtonTouched(sender:)), for: .touchUpInside)
    
    let barItem = UIBarButtonItem(customView: button)
    custombar.items?.append(barItem)
    
    custombar.items?.append(space)
}
containerView.addSubview(custombar)

let imageBar = UIToolbar(frame: CGRect(x: 0, y: 100, width: 250, height: 45))
imageBar.clipsToBounds = true
imageBar.barTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
imageBar.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
imageBar.items = [
    UIBarButtonItem(image: "🚶".image, style: .plain, target: controller, action: #selector(Controller.imageButtonTouched(sender:))),
    space,
    UIBarButtonItem(image: "🚲".image, style: .plain, target: controller, action: #selector(Controller.imageButtonTouched(sender:))),
    space,
    UIBarButtonItem(image: "🚘".image, style: .plain, target: controller, action: #selector(Controller.imageButtonTouched(sender:))),
    space,
    UIBarButtonItem(image: "🚂".image, style: .plain, target: controller, action: #selector(Controller.imageButtonTouched(sender:))),
    space,
    UIBarButtonItem(image: "✈️".image, style: .plain, target: controller, action: #selector(Controller.imageButtonTouched(sender:)))
    ]

containerView.addSubview(imageBar)

PlaygroundPage.current.liveView = containerView
