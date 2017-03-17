//
//  ViewController.swift
//  improcessor
//
//  Created by Илья Лошкарёв on 09.03.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var filterButton: UIBarButtonItem!
    
    var currentFilterName = "CIColorInvert"
    let context = CIContext()
    
    var miniature: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
        scrollView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cameraButtonTouched(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
    @IBAction func saveButtonTouched(_ sender: UIBarButtonItem) {
        UIImageWriteToSavedPhotosAlbum(imageView.image!, self, #selector(image(_:didFinishSavingWithError: contextInfo:)), nil)

    }
    
    @IBAction func cameraButtonTouched(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: imagePicker.sourceType)!
        
        imagePicker.delegate = self
        imagePicker.modalPresentationStyle = .popover
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func filterButtonTouched(_ sender: Any) {
        process(image: imageView.image!)
    }
    
    // MARK: ImageDidFinishSavingWithError
    
    func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        guard error == nil else {
            print ("saveing error")
            return
        }
        
        let alert = UIAlertController(title: "Saved", message: "Image saved to default photo album", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
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
        miniature = createMiniature(from: imageView.image!)
        filterButton.image = filter(inputImage: miniature)
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
        return filter.apply(to: image)?.withRenderingMode(.alwaysOriginal)
    }
    
    func update(with image: UIImage) {
        scrollView.setZoomScale(scrollView.maximumZoomScale, animated: false)
        
        imageView.frame = CGRect(origin: CGPoint.zero, size: image.size)
        imageView.image = image
        
        miniature = createMiniature(from: image)
        filterButton.image = filter(inputImage: miniature)
        
        scrollView.contentSize = image.size
        scrollView.minimumZoomScale = max(scrollView.frame.width  / image.size.width,
                                          scrollView.frame.height / image.size.height)
        
        scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
    }
    
    func createMiniature(from image: UIImage) -> UIImage {
        let height: CGFloat = 30
        let width = image.size.width * height / image.size.height
        
        UIGraphicsBeginImageContext( CGSize(width: width, height: height))
        imageView.image!.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
}

