//
//  TableViewCell.swift
//  schedule
//
//  Created by mmcs on 29.03.17.
//  Copyright © 2017 mmcs. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    class var defaultHeight: CGFloat { return 44 }
}

class TableViewCell: UITableViewCell {
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var timeLabel: UILabel!
}

class DetailTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var smallDetail: UILabel!
    @IBOutlet weak var largeDetail: UILabel!
}
