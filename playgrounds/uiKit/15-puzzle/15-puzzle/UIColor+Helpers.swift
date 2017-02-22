//
//  UIColor+Helpers.swift
//  15-puzzle
//
//  Created by Илья Лошкарёв on 19.02.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(hue: CGFloat(drand48()), saturation: 0.8, brightness: 0.8, alpha: 1)
    }
    
    var darker: UIColor? {
        var hue: CGFloat = 0
        var sat: CGFloat = 0
        var bri: CGFloat = 0
        var alp: CGFloat = 0
        let didGet = getHue(UnsafeMutablePointer(&hue),
                            saturation: UnsafeMutablePointer(&sat),
                            brightness: UnsafeMutablePointer(&bri),
                            alpha: UnsafeMutablePointer(&alp))
            return didGet ? UIColor(hue: hue, saturation: sat, brightness: bri * 0.3, alpha: alp) : nil
    }
}
