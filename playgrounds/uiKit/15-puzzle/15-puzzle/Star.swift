//
//  Star.swift
//  15-puzzle
//
//  Created by Илья Лошкарёв on 09.03.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit

extension UIBezierPath {
    convenience init(starWithNumberOfPoints starPoints: Int, centeredAt center: CGPoint, innerRadius inRadius: CGFloat, outerRadius outRadius: CGFloat) {
        self.init()
        let angle = 2 * M_PI / Double(starPoints)
        
        for i in 0..<starPoints {
            let inPoint = CGPoint(x: center.x + inRadius * CGFloat(cos(angle * Double(i))), y: center.y + inRadius * CGFloat(sin(angle * Double(i))))
            if i == 0 { self.move(to: inPoint) }
            else { self.addLine(to: inPoint) }
            
            let outPoint = CGPoint(x: center.x + outRadius * CGFloat(cos(angle * (Double(i)+0.5))), y: center.y + outRadius * CGFloat(sin(angle * (Double(i)+0.5))))
            self.addLine(to: outPoint)
        }
        self.close()
    }
}

struct Star {
    
    let points: Int
    
    var inOut: CGFloat = 0.5
    
    init?(points: Int) {
        guard points > 3 else {
            return nil
        }
        self.points = points
    }
    
    func image(of size: CGSize, starColor color: UIColor = UIColor.white) -> UIImage? {
        UIGraphicsBeginImageContext(size)

        let center = CGPoint(x: size.width / 2, y: size.height / 2)
        let radius = min(size.width, size.height) / 2
        let starPath = UIBezierPath(starWithNumberOfPoints: points, centeredAt: center, innerRadius: radius * inOut, outerRadius: radius)
        
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.addPath(starPath.cgPath)
            context.fillPath()
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
