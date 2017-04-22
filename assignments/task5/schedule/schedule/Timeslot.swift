//
//  Timeslot.swift
//  schedule
//
//  Created by mmcs on 29.03.17.
//  Copyright © 2017 mmcs. All rights reserved.
//

import Foundation

struct Lesson {
    let subject: String
    let abbreviation: String
    let teacher: String
    let teacherDegree: String
    let room: String
}

enum AlternatingWeek: String {
    case full, upper, lower
    
    init?(id: Int) {
        switch id {
        case 0: self = .upper
        case 1: self = .lower
        default: return nil
        }
    }
}

class Timeslot: Hashable {
    var weekday = 0
    var startTime = DateComponents()
    var endTime = DateComponents()
    var alternating = AlternatingWeek.full
    var lessons = [Lesson]()
    
    static var inputTimeFormatter : DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "HH:mm:ss"
        df.timeZone = TimeZone.current
        return df
    }()
    
    static var outputTimeFormatter : DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "HH:mm"
        df.timeZone = TimeZone.current
        return df
    }()
    
    init?(_ string: String) {
        guard
            let matches = string.matches(forPattern: "[(]{1}(.+),(.+),(.+),(.+)[)]{1}"),
            let weekday = Int(matches[0][1]),
            let startDate = Timeslot.inputTimeFormatter.date(from: matches[0][2]),
            let endDate = Timeslot.inputTimeFormatter.date(from: matches[0][3]),
            let alternating = AlternatingWeek(rawValue: matches[0][4])
        else { return nil }
        
        self.weekday = weekday
        startTime = Calendar.current.dateComponents([.hour,.minute,.second], from: startDate)
        startTime.calendar = Calendar.current
        endTime = Calendar.current.dateComponents([.hour,.minute,.second], from: endDate)
        endTime.calendar = Calendar.current
        self.alternating = alternating
    }
    
    // MARK: - Hashable
    
    static func == (_ t1: Timeslot, _ t2: Timeslot) -> Bool {
        return t1.weekday == t2.weekday &&
            t1.startTime == t2.startTime &&
            t1.endTime == t2.endTime &&
            t1.alternating == t2.alternating
    }

    var hashValue: Int {
        return weekday.hashValue ^ startTime.hashValue ^ endTime.hashValue ^ alternating.hashValue
    }

}

