//
//  DetailViewController.swift
//  apod-viewer
//
//  Created by Илья Лошкарёв on 19.04.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    func configureViews() {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy"
        if let picture = detailItem {
            imageView?.image = UIImage(imageLiteralResourceName: picture.source!)
            titleLabel?.text = picture.title
            dateLabel?.text = df.string(from: picture.date!)
            textField?.text = picture.subtitle
        }
    }
    
    var detailItem: Picture? {
        didSet{ configureViews() }
    }

}
