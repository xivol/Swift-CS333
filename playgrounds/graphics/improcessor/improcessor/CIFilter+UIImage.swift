//
//  CIFilter+UIImage.swift
//  improcessor
//
//  Created by Илья Лошкарёв on 15.03.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit

extension CIFilter {
    func apply(to image: UIImage) -> UIImage? {
        if let ciImage = CIImage(image: image) {
            self.setValue(ciImage, forKey: kCIInputImageKey)
        } else {
            print ("Wrong image", image)
            return nil
        }
        
        if let outputImage = self.outputImage {
            let result = CIContext().createCGImage(outputImage, from: outputImage.extent)
            return UIImage(cgImage: result!)
        } else {
            print ("Empty output", self)
            return nil
        }
    }
}


