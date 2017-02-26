import UIKit
import PlaygroundSupport
class Zoom: NSObject, UIScrollViewDelegate {
    let content: UIView?
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return content
    }
    
    init(content: UIView) {
        self.content=content
    }
}

let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 400, height: 250))

let imageView = UIImageView(image: #imageLiteral(resourceName: "swift.png"))

scrollView.contentSize = imageView.image!.size
scrollView.bounces = true
scrollView.bouncesZoom = true
scrollView.minimumZoomScale = 0.1
scrollView.zoomScale = 0.5
scrollView.delegate = Zoom(content: imageView)
scrollView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
scrollView.addSubview(imageView)

PlaygroundPage.current.liveView = scrollView
