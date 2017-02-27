import UIKit
import PlaygroundSupport

let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 250))
imageView.image = #imageLiteral(resourceName: "swift.png")
imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//: ### Content Mode
imageView.contentMode = .scaleAspectFit
//: ### Animation Images
let moonView = UIImageView(frame: CGRect(x: 10, y: 10, width: 50, height: 50))
let moon = ["🌑".image, "🌘".image, "🌗".image, "🌖".image, "🌕".image, "🌔".image, "🌓".image, "🌒".image]
moonView.animationImages = moon
moonView.animationRepeatCount = -1
moonView.animationDuration = 1
imageView.addSubview(moonView)

PlaygroundPage.current.liveView = imageView
moonView.startAnimating()