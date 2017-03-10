//
//  ViewController.swift
//  improcessor
//
//  Created by Илья Лошкарёв on 09.03.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var currentFilterName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
        scrollView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cameraButtonTouched(self)
    }
    
    // MARK: Actions
    
    @IBAction func saveButtonTouched(_ sender: UIBarButtonItem) {
        //print(imageView.image?.cgImage)
        let activity = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: nil)
        present(activity, animated:true, completion:nil)
    }
    
    @IBAction func cameraButtonTouched(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: imagePicker.sourceType)!
        
        imagePicker.delegate = self
        imagePicker.modalPresentationStyle = .popover
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: ImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true) {
            self.activityIndicator.stopAnimating()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        dismiss(animated: true, completion: nil)
        update(with: info[UIImagePickerControllerOriginalImage] as! UIImage)
    }
    
    // MARK: ScrollViewDelegate
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    // MARK: Image Processing
    
    func process(image: UIImage) {
        self.imageView.alpha = 0.1
        self.activityIndicator.startAnimating()
        self.scrollView.isUserInteractionEnabled = false
        
        DispatchQueue.global().async {
            [weak self] in
            guard let resultImage = self?.filter(inputImage: image)
            else {
                return
            }
            DispatchQueue.main.sync {
                [weak self] in
                self?.update(with: resultImage)
                
                self?.activityIndicator.stopAnimating()
                self?.scrollView.isUserInteractionEnabled = true
                self?.saveButton.isEnabled = true
                UIView.animate(withDuration: 0.5) {
                    self?.imageView.alpha = 1
                }
            }
        }

    }
    
    func filter(inputImage image: UIImage) -> UIImage? {
        guard let filter = CIFilter(name: currentFilterName)
        else {
            print("Wrong filter", currentFilterName)
            return nil
        }
        
        if let ciImage = CIImage(image: image) {
            filter.setValue(ciImage, forKey: kCIInputImageKey)
        } else {
            print ("Wrong image", image)
            return nil
         }
        
        if let outputImage = filter.outputImage {
            UIGraphicsBeginImageContext(outputImage.extent.size)
            let ctx = CIContext(cgContext: UIGraphicsGetCurrentContext()!, options: nil)
            let result = ctx.createCGImage(outputImage, from: outputImage.extent)
            UIGraphicsEndImageContext()
            
            return UIImage(cgImage: result!)
        } else {
            print ("Empty output", filter)
            return nil
        }
        
    }
    
    func update(with image: UIImage) {
        scrollView.setZoomScale(scrollView.maximumZoomScale, animated: false)
        
        imageView.frame = CGRect(origin: CGPoint.zero, size: image.size)
        imageView.image = image
        
        scrollView.contentSize = image.size
        scrollView.minimumZoomScale = max(scrollView.frame.width  / image.size.width,
                                          scrollView.frame.height / image.size.height)
        
        scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let filters = segue.destination as? FiltersTableViewController else {
            return
        }
        filters.setFilter = {
            [weak self] filterName in
            self?.currentFilterName = filterName
            self?.process(image: (self?.imageView.image)!)
        }
    }
    
}

