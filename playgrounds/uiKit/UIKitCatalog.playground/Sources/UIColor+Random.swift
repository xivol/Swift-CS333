import Foundation
import UIKit

public extension UIColor {
    public static var random: UIColor {
        return UIColor(hue: CGFloat(drand48()), saturation: 1, brightness: 1, alpha: 1)
    }
}

