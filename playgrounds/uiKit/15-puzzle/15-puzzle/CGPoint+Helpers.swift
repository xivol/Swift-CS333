//
//  CGPoint+Helpers.swift
//  15-puzzle
//
//  Created by Илья Лошкарёв on 22.02.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit

func +(_ a: CGPoint, _ b: CGPoint) -> CGPoint {
    return CGPoint(x: a.x + b.x, y: a.y + b.y)
}

func +=(_ a: inout CGPoint, _ b: CGPoint) {
    a = CGPoint(x: a.x + b.x, y: a.y + b.y)
}

func -(_ a: CGPoint, _ b: CGPoint) -> CGPoint {
    return CGPoint(x: a.x - b.x, y: a.y - b.y)
}

func -=(_ a: inout CGPoint, _ b: CGPoint) {
    a = CGPoint(x: a.x - b.x, y: a.y - b.y)
}

func *(_ a: CGFloat, _ b: CGPoint) -> CGPoint {
    return CGPoint(x: a * b.x, y: a * b.y)
}
func *(_ a: CGPoint, _ b: CGFloat) -> CGPoint {
    return b * a
}

func *=(_ a: inout CGPoint, _ b: CGFloat) {
    a = CGPoint(x: a.x * b, y: a.y * b)
}
