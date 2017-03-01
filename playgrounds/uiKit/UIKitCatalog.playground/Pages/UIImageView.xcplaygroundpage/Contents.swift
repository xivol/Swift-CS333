//: # UIImageView
//: A `UIImageView` object displays a single image or a sequence of animated images in your interface. Image views let you efficiently draw any image that can be specified using a `UIImage` object.
//:
//: [UIImageView API Reference](https://developer.apple.com/reference/uikit/uiimageview)
import UIKit
import PlaygroundSupport
//: Initialize with frame
let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 400))
imageView.image = #imageLiteral(resourceName: "swift.png")
imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//: ### Content Mode
imageView.contentMode = .scaleAspectFit
//: ### Animated Images
let moonView = UIImageView(frame: CGRect(x: 10, y: 10, width: 50, height: 50))
let moon = ["🌑".image, "🌘".image, "🌗".image, "🌖".image,
            "🌕".image, "🌔".image, "🌓".image, "🌒".image]
// Rasterzed String content wit String+Image.swift
moonView.animationImages = moon
moonView.animationRepeatCount = -1
moonView.animationDuration = 1
moonView.contentMode = .center
imageView.addSubview(moonView)
//: ### Image Template Mode
let template = "🛠".image.withRenderingMode(.alwaysTemplate)
let templateView = UIImageView(image: template)
templateView.frame = CGRect(x: 60, y: 10, width: 50, height: 50)
templateView.contentMode = .center

templateView.tintColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)

imageView.addSubview(templateView)


PlaygroundPage.current.liveView = imageView
moonView.startAnimating()
