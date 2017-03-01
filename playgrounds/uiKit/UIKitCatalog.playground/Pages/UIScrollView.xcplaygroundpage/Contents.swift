//: # UIScrollView
//: The UIScrollView class provides support for displaying content that is larger than the size of the application’s window. It enables users to scroll within that content by making swiping gestures, and to zoom in and back from portions of the content by making pinching gestures.
//:
//:[UIScrollView API Reference](https://developer.apple.com/reference/uikit/uiscrollview)

import UIKit
import PlaygroundSupport
class Zoom: NSObject, UIScrollViewDelegate {
    let content: UIView?
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return content
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        print("zooom")
    }
    
    init(content: UIView) {
        self.content = content
    }
}
//: ### Initialize Scroll View
let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 250, height: 400))
scrollView.bounces = true
scrollView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//: ### Add Content
let imageView = UIImageView(image: #imageLiteral(resourceName: "swift.png"))
scrollView.contentSize = imageView.image!.size
scrollView.addSubview(imageView)
//: ### Add Delegate for Zoom
//??? Zoom seems to be broken in Playground Simulator ???
let zoomDelegate = Zoom(content: imageView)
scrollView.bouncesZoom = false
scrollView.minimumZoomScale = scrollView.bounds.width / imageView.bounds.width
scrollView.maximumZoomScale = 1
scrollView.delegate = zoomDelegate

PlaygroundPage.current.liveView = scrollView
