//
//  Note.swift
//  notes-archive
//
//  Created by Илья Лошкарёв on 18.03.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import Foundation
import UIKit

class Note: NSObject, NSCoding {
    
    let content: String
    let date: Date
    let color: UIColor
    
    init(content: String, date: Date = Date(), color: UIColor = UIColor.random) {
        self.content = content
        self.date = date
        self.color = color
    }
    
    // MARK: NSCoding
    
    enum CodingKeys: String {
        case content, date, color
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard
            let content = aDecoder.decodeObject(forKey: CodingKeys.content.rawValue) as? String,
            let date = aDecoder.decodeObject(forKey: CodingKeys.date.rawValue) as? Date
        else {
                return nil
        }
        
        if let color = aDecoder.decodeObject(forKey: CodingKeys.color.rawValue) as? UIColor {
            self.init(content: content, date: date, color: color)
        } else {
            self.init(content: content, date: date)
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(content, forKey: CodingKeys.content.rawValue)
        aCoder.encode(date, forKey: CodingKeys.date.rawValue)
        aCoder.encode(color, forKey: CodingKeys.color.rawValue)
    }
    
    // MARK: String Convertable

    static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "hh:mm:ss dd.MM.yyyy"
        return df
    }()
    
    override var description: String {
        return "(\(Note.dateFormatter.string(from: date))) " + content
    }
}
