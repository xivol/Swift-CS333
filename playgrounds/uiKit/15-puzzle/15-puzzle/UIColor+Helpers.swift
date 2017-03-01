//
//  UIColor+Helpers.swift
//  15-puzzle
//
//  Created by Илья Лошкарёв on 19.02.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit

extension UIColor {
    struct HSBComponents {
        var hue: CGFloat
        var saturation: CGFloat
        var brightness: CGFloat
        var alpha: CGFloat
    }
    
    var hsb: HSBComponents? {
        var hue: CGFloat = 0
        var sat: CGFloat = 0
        var bri: CGFloat = 0
        var alp: CGFloat = 0
        let didGet = self.getHue(UnsafeMutablePointer(&hue),
                                 saturation: UnsafeMutablePointer(&sat),
                                 brightness: UnsafeMutablePointer(&bri),
                                 alpha: UnsafeMutablePointer(&alp))
        return didGet ? HSBComponents(hue: hue, saturation: sat, brightness: bri, alpha: alp) : nil
    }
    
    convenience init(components hsb: HSBComponents) {
        self.init(hue: hsb.hue, saturation: hsb.saturation, brightness: hsb.brightness, alpha: hsb.alpha)
    }
    
    static var random: UIColor {
        return UIColor(hue: CGFloat(drand48()), saturation: 0.8, brightness: 0.8, alpha: 1)
    }
    
    var darkened: UIColor? {
        if var hsb = self.hsb {
            hsb.brightness *= 0.3
            return UIColor(components: hsb)
        }
        return nil
    }
}
