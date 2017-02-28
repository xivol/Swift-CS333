import UIKit
import Foundation
//http://stackoverflow.com/questions/38809425/convert-apple-emoji-string-to-uiimage

public extension String {
    public var image: UIImage {
        let size = CGSize(width: 30, height: 35)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        let rect = CGRect(origin: CGPoint.zero, size: size)
        UIColor.clear.setFill()
        UIRectFill(rect)
        
        let nsString = self as NSString
        let font = UIFont.systemFont(ofSize: size.width)
        nsString.draw(in: rect, withAttributes: [NSFontAttributeName: font])
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
