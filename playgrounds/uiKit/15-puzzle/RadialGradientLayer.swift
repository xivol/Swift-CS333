//
//  RadialGradientLayer.swift
//  15-puzzle
//
//  Created by Илья Лошкарёв on 21.02.17.
//  http://stackoverflow.com/a/31854064
//

import UIKit

class RadialGradientLayer: CALayer {
    var center: CGPoint!
    var radius: CGFloat!
    var colors: [CGColor] = [UIColor.clear.cgColor , UIColor.clear.cgColor]
    
    override var cornerRadius: CGFloat {
        didSet {
            let mask = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            let maskLayer = CAShapeLayer()
            maskLayer.frame = bounds
            maskLayer.path = mask.cgPath
            self.mask = maskLayer
        }
    }
    
    override init() {
        super.init()
        needsDisplayOnBoundsChange = true
    }
    
    override init(layer: Any){
        guard let source = layer as? RadialGradientLayer else {
            super.init(layer: layer)
            return
        }
        center = source.center
        radius = source.radius
        colors = source.colors
        super.init(layer: layer)
    }
    
    init(center: CGPoint, radius: CGFloat, colors: [CGColor]){
        self.center = center
        self.radius = radius
        self.colors = colors
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        center = aDecoder.decodeCGPoint(forKey: "center")
        radius = CGFloat(aDecoder.decodeDouble(forKey: "radius"))
        colors = aDecoder.decodeObject(forKey: "colors") as! [CGColor]
     }
    
    override func draw(in ctx: CGContext) {
        ctx.saveGState()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: [0.0,1.0])
        CGLayer(ctx, size: CGSize.zero, auxiliaryInfo: nil)
        
        //ctx.addPath(UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath)
        //ctx.clip() ??? no AA
        
        ctx.drawRadialGradient(gradient!, startCenter: center, startRadius: 0, endCenter: center, endRadius: radius, options: .drawsAfterEndLocation)
    }
    
}
