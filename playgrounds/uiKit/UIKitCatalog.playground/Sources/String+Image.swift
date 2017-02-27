import UIKit
import Foundation
//http://stackoverflow.com/questions/38809425/convert-apple-emoji-string-to-uiimage

public extension String {
    public var image: UIImage {
        let size = CGSize(width: 30, height: 35)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let rect = CGRect(origin: CGPoint.zero, size: size)
        UIColor.clear.setFill()
        UIRectFill(CGRect(origin: CGPoint.zero, size: size))
        (self as NSString).draw(in: rect, withAttributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 30)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
