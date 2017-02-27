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

let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 400, height: 250))

let imageView = UIImageView(image: #imageLiteral(resourceName: "swift.png"))

scrollView.contentSize = imageView.image!.size
scrollView.addSubview(imageView)
scrollView.bounces = true
scrollView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

let zoomDelegate = Zoom(content: imageView)
scrollView.bouncesZoom = false
scrollView.minimumZoomScale = scrollView.bounds.width / imageView.bounds.width
scrollView.maximumZoomScale = 1
scrollView.delegate = zoomDelegate // ??? doesn't work in playground ???

PlaygroundPage.current.liveView = scrollView
