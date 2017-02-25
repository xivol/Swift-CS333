//
//  UIColor+Helpers.swift
//  15-puzzle
//
//  Created by Илья Лошкарёв on 19.02.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit

extension UIColor {
    struct HSVComponents {
        var hue: CGFloat
        var saturation: CGFloat
        var brightness: CGFloat
        var alpha: CGFloat
    }
    
    var hsv: HSVComponents? {
        var hue: CGFloat = 0
        var sat: CGFloat = 0
        var bri: CGFloat = 0
        var alp: CGFloat = 0
        let didGet = self.getHue(UnsafeMutablePointer(&hue),
                                 saturation: UnsafeMutablePointer(&sat),
                                 brightness: UnsafeMutablePointer(&bri),
                                 alpha: UnsafeMutablePointer(&alp))
        return didGet ? HSVComponents(hue: hue, saturation: sat, brightness: bri, alpha: alp) : nil
    }
    
    convenience init(components hsv: HSVComponents) {
        self.init(hue: hsv.hue, saturation: hsv.saturation, brightness: hsv.brightness, alpha: hsv.alpha)
    }
    
    static var random: UIColor {
        return UIColor(hue: CGFloat(drand48()), saturation: 0.8, brightness: 0.8, alpha: 1)
    }
    
    var darkened: UIColor? {
        if var hsv = self.hsv {
            hsv.brightness *= 0.3
            return UIColor(components: hsv)
        }
        return nil
    }
}
