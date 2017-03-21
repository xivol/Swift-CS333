//
//  ConfettiView.swift
//  15-puzzle
//
//  Created by Илья Лошкарёв on 24.02.17.
//  http://stackoverflow.com/documentation/ios/1462/calayer/16237/emitter-view-with-custom-image#t=201702241334159368478
//

import UIKit

class ConfettiView: UIView {
    // main emitter layer
    var emitter: CAEmitterLayer!
    
    // array of color to emit
    var colors: [UIColor]!
    
    // intensity of appearance
    var intensity: Float!
    
    private var active :Bool!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        // initialization
        colors = [UIColor.yellow, UIColor.yellow, UIColor.yellow, UIColor.white]
        intensity = 0.5
        active = false
    }
    
    func startConfetti() {
        emitter = CAEmitterLayer()
        
        emitter.emitterPosition = CGPoint(x: bounds.width / 2, y: -bounds.height / 2)
        emitter.emitterShape = kCAEmitterLayerLine
        emitter.emitterSize = CGSize(width: frame.size.width, height: 1)
        
        var cells = [CAEmitterCell]()
        for color in colors {
            cells.append(confettiWithColor(color: color))
        }
        
        emitter.emitterCells = cells
        layer.addSublayer(emitter)
        active = true
    }
    
    func stopConfetti() {
        emitter?.birthRate = 0
        active = false
    }
    
    func confettiWithColor(color: UIColor) -> CAEmitterCell {
        let confetti = CAEmitterCell()
        
        confetti.birthRate = 10.0 * intensity
        confetti.lifetime = 180.0 * intensity
        confetti.color = color.cgColor
        confetti.velocity = CGFloat(350.0 * intensity)
        confetti.emissionLongitude = CGFloat(M_PI)
        confetti.emissionRange = CGFloat(M_PI_4)
        confetti.spin = CGFloat(3.5 * intensity)
        confetti.spinRange = CGFloat(4.0 * intensity)

        let star = Star(points: 5)
        
        if let image = star?.image(of: CGSize(width: 30, height: 30)) {
        // WARNING: A layer should set this property to a CGImage to display the image as its contents.
            confetti.contents = image.cgImage
            confetti.scale = 0.05 * bounds.width / image.size.width
        }  else {
            print("No confetti image!")
        }
        return confetti
    }
    
    internal func isActive() -> Bool {
        return self.active
    }
}
