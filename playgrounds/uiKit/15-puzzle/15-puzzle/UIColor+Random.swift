//
//  UIColor+Random.swift
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
}
