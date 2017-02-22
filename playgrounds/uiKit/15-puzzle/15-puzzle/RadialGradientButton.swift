//
//  RadialGradientButton.swift
//  15-puzzle
//
//  Created by Илья Лошкарёв on 21.02.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit

class RadialGradientButton: UIButton {

    @IBInspectable var cornerRadius: Float {
        get{ return Float(gradientLayer.cornerRadius)}
        set{ gradientLayer.cornerRadius = CGFloat(newValue)}
    }
    
    @IBInspectable var startColor: UIColor {
        get { return UIColor(cgColor: gradientLayer.colors[0]) }
        set { gradientLayer.colors = [newValue.cgColor, endColor.cgColor] }
    }
    
    @IBInspectable var endColor: UIColor {
        get { return UIColor(cgColor: gradientLayer.colors[1]) }
        set { gradientLayer.colors = [startColor.cgColor, newValue.cgColor] }
    }
    
    override class var layerClass: Swift.AnyClass { get { return RadialGradientLayer.self } }
    
    var gradientLayer: RadialGradientLayer { return layer as! RadialGradientLayer }
    
    func initGradient() {
        gradientLayer.center = CGPoint(x: bounds.origin.x + bounds.width / 2, y: bounds.origin.y + bounds.height / 2)
        gradientLayer.radius = sqrt(bounds.width * bounds.width + bounds.height * bounds.height)
        for view in subviews{
            view.backgroundColor = UIColor.clear
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initGradient()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initGradient()
    }
}

// PuzzleTile
extension RadialGradientButton {
    static func puzzleTile(frame: CGRect, color: UIColor) -> RadialGradientButton {
        let button = RadialGradientButton(frame: frame)
        button.bounds = CGRect(x: 1, y: 1, width: frame.width - 1, height: frame.height - 1)
        button.startColor = color
        button.endColor = color.darker!
        // Title
        button.titleLabel?.font = button.titleLabel?.font.withSize(button.bounds.width / 2)
        // Corners
        button.layer.cornerRadius = button.bounds.width * 0.2
        return button
    }
}
