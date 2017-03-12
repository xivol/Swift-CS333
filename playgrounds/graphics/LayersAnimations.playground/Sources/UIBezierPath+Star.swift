import UIKit

public extension CGMutablePath {
    public func addStar(withNumberOfPoints starPoints: Int, centeredAt center: CGPoint, innerRadius inRadius: CGFloat, outerRadius outRadius: CGFloat) {
        let angle = 2 * M_PI / Double(starPoints)
        
        for i in 0..<starPoints {
            let inPoint = CGPoint(x: center.x + inRadius * CGFloat(cos(angle * Double(i))), y: center.y + inRadius * CGFloat(sin(angle * Double(i))))
            
            if i == 0 { self.move(to: inPoint) }
            else { self.addLine(to: inPoint) }
            
            let outPoint = CGPoint(x: center.x + outRadius * CGFloat(cos(angle * (Double(i)+0.5))), y: center.y + outRadius * CGFloat(sin(angle * (Double(i)+0.5))))
            self.addLine(to: outPoint)
        }
        self.closeSubpath()
    }
    
    public static func star(withNumberOfPoints starPoints: Int, centeredAt center: CGPoint, innerRadius inRadius: CGFloat, outerRadius outRadius: CGFloat) -> CGPath {
        let path = CGMutablePath()
        path.addStar(withNumberOfPoints: starPoints, centeredAt: center, innerRadius: inRadius, outerRadius: outRadius)
        return path
    }
}

public extension UIBezierPath {
    public convenience init(starWithNumberOfPoints starPoints: Int, centeredAt center: CGPoint, innerRadius inRadius: CGFloat, outerRadius outRadius: CGFloat) {
        self.init(cgPath: CGMutablePath.star(withNumberOfPoints: starPoints, centeredAt: center, innerRadius: inRadius, outerRadius: outRadius))
    }
}
