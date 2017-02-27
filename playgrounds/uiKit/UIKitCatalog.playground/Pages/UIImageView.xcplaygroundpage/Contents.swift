import UIKit
import PlaygroundSupport

let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 250))
imageView.image = #imageLiteral(resourceName: "swift.png")
imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
imageView.contentMode = .scaleAspectFit

let swift = [#imageLiteral(resourceName: "be69f2c45a863187c8bc03c8711.jpg"),#imageLiteral(resourceName: "bb95380c1ee8bfbedcbe38b89c4.jpg"),#imageLiteral(resourceName: "beb3f1603f08ed48f29d0654c1a.jpg")]
imageView.animationImages = swift
imageView.animationRepeatCount = -1
imageView.animationDuration = 1.5
//imageView.startAnimating()

PlaygroundPage.current.liveView = imageView
