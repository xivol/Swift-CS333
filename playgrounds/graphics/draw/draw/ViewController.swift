//
//  ViewController.swift
//  draw
//
//  Created by Илья Лошкарёв on 09.10.16.
//  Copyright © 2016 Илья Лошкарёв. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var taped = false
    var lastPoint = CGPoint.zero
    var strokeWidth: CGFloat = 12.0
    var strokeColor = UIColor.blue
    
    var imageView: UIImageView {
        return view as! UIImageView
    }
    
    var linePath: UIBezierPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = UIImageView(frame: view.bounds)
        view.backgroundColor = UIColor.white
        view.isUserInteractionEnabled = true
        
        let press = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        view.addGestureRecognizer(press)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        taped = true
        if let touch = touches.first {
            lastPoint = touch.location(in: view)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        taped = false
        if let touch = touches.first {
            let currentPoint = touch.location(in: view)
            drawLine(from: lastPoint, to: currentPoint)
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if taped {
            drawLine(from: lastPoint, to: lastPoint)
        }
    }
    
    func longPress() {
        let activity = UIActivityViewController(activityItems: [imageView.image as Any], applicationActivities: nil)
        present(activity, animated:true, completion:nil)
    }
    
    func drawLine(from fromPoint: CGPoint, to toPoint:CGPoint) {
        
        UIGraphicsBeginImageContext(view.frame.size)
        imageView.image?.draw(in: CGRect(origin: CGPoint.zero, size: view.frame.size))
        
        let linePath = UIBezierPath()
        
        linePath.move(to: fromPoint)
        linePath.addLine(to: toPoint)
        
        strokeColor.setStroke()
        linePath.lineWidth = strokeWidth
        linePath.lineCapStyle = .round
        linePath.lineJoinStyle = .round
        linePath.stroke()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
}

