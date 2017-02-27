import UIKit
import PlaygroundSupport

class Controller {
    let views: UIView!
    @objc func valueChanged(sender: UISegmentedControl) {
        guard let visible = views.subviews.index(where: { $0.isHidden == false }) else {
            views.subviews[sender.selectedSegmentIndex].isHidden = false
            return
        }
        if visible != sender.selectedSegmentIndex {
            UIView.transition(from: views.subviews[visible], to: views.subviews[sender.selectedSegmentIndex], duration: 0.5, options: [.showHideTransitionViews, .transitionFlipFromBottom], completion: nil)
        }
    }
    
    init(with views: UIView){
        self.views = views
    }
}

let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 200))
containerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

let imageControl = UISegmentedControl(frame: CGRect(x: 0, y: 10, width: 250, height: 60))
for str in ["♠️","♣️","♥️","♦️"] {
    imageControl.insertSegment(with: str.image, at: 4, animated: true)
}
imageControl.tintColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
containerView.addSubview(imageControl)

let segmentedControl = UISegmentedControl(frame: CGRect(x: 0, y: 80, width: 250, height: 30))
var views = UIView(frame: CGRect(x: 0, y: 120, width: 250, height: 70))
containerView.addSubview(views)

let number = 8
let formatter = NumberFormatter()
formatter.numberStyle = .spellOut

for i in 1...number {
    segmentedControl.insertSegment(withTitle: "\(i)", at: UInt(number), animated: false) // sintax error?
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 70))
    
    label.isHidden = true
    label.textAlignment = .center
    label.textColor = .white
    label.text = formatter.string(from: NSNumber(integerLiteral: i))?.capitalized
    
    views.addSubview(label)
    
}

for i in 0..<number {
    let segmentColor = UIColor(displayP3Red: CGFloat(i) * 0.2, green: CGFloat(i) * 0.1, blue: CGFloat(number - i) * 0.2, alpha: 1)
    segmentedControl.subviews[number - i - 1].tintColor = segmentColor
    views.subviews[i].backgroundColor = segmentColor
    views.subviews[i].layer.cornerRadius = 2
}

let colorController = Controller(with: views)
segmentedControl.addTarget(colorController, action: #selector(Controller.valueChanged(sender:)), for: .valueChanged)
containerView.addSubview(segmentedControl)

PlaygroundPage.current.liveView = containerView
