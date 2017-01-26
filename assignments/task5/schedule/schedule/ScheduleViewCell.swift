//
//  ScheduleViewCell.swift
//  schedule
//
//  Created by Илья Лошкарёв on 19.01.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit

class ScheduleViewCell: UITableViewCell, XibLoadableView {
    static let identifier = "ScheduleViewCell"
    @IBOutlet weak var className: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var room: UILabel!
    
    var lesson: ScheduleItem! {
        didSet {

            className.text = lesson.subject
            room.text = "ауд." + "\(lesson.room)"
            let breakStart = lesson.startTime + Schedule.lessonDuration
            let breakEnd = lesson.endTime - Schedule.lessonDuration
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.dateStyle = .none
            
            startTime.text = formatter.string(from: lesson.startTime) + "\n" +
                        formatter.string(from: breakStart)
            endTime.text = formatter.string(from: breakEnd) + "\n" +
                        formatter.string(from: lesson.endTime)
        }
    }
    // TO DO:
    // https://medium.com/@gonzalezreal/ios-cell-registration-reusing-with-swift-protocol-extensions-and-generics-c5ac4fb5b75e#.4y5zbhgza
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
