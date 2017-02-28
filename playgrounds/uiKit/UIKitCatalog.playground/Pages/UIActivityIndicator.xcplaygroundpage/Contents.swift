import UIKit
import PlaygroundSupport

let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
//containerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

let number = 6
let size = CGSize(width: containerView.bounds.width / CGFloat(number),
                  height: containerView.bounds.width / CGFloat(number))
for i in 0..<number {
    for j in 0..<number {
        let frame = CGRect(x: CGFloat(i) * size.width, y: CGFloat(j) * size.height, width: size.width, height: size.height)
        let indicator = UIActivityIndicatorView(frame: frame)
        
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.color = UIColor.random
        
        indicator.hidesWhenStopped = false
        indicator.startAnimating()
        
        if (i + j) % (number - 1) == 0 {
            indicator.stopAnimating()
            indicator.color = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
        
        containerView.addSubview(indicator)
        
    }
}

PlaygroundPage.current.liveView = containerView
