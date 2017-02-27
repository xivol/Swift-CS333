import UIKit
import PlaygroundSupport

let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
//containerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

let number = 5
let size = CGSize(width: 50, height: 50)
for i in 0..<number {
    for j in 0..<number {
        let frame = CGRect(x: CGFloat(i) * size.width, y: CGFloat(j) * size.height, width: size.width, height: size.height)
        let indicator = UIActivityIndicatorView(frame: frame)
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.color = UIColor.random
        indicator.hidesWhenStopped = false
        indicator.startAnimating()
        
        containerView.addSubview(indicator)
        
        if (i + j) % (number - 1) == 0 {
            indicator.stopAnimating()
            indicator.color = .darkGray
        }
    }
}

PlaygroundPage.current.liveView = containerView