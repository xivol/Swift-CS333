//
//  Schedule.swift
//  schedule
//
//  Created by Илья Лошкарёв on 19.01.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import Foundation

extension Int {
    var minutes: TimeInterval {
        get { return TimeInterval( exactly: Double(self * 60))! }
    }
}

struct Schedule {
    static let lessonDuration = 45.minutes
    
    enum Week: Int, CustomStringConvertible {
        case upper, lower
        
        static var current: Week {
            get {
                return Week.get(for: Date())
            }
        }
        
        static func get(for date: Date = Date()) -> Week {
            let calendar = NSCalendar.current
            let components = calendar.dateComponents([.weekOfYear], from: date)
            return Week(rawValue: components.weekOfYear! % 2)!
        }
        
        var description: String {
            get {
                switch self {
                case .upper:
                    return "верхняя"
                case .lower:
                    return "нижняя"
                }
            }
        }
        
    }
    
    static let dummy: [ScheduleItem] = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        return [
            ScheduleItem(subject: "Мат. анализ", startTime: formatter.date(from: "8:00")!,
                         endTime: formatter.date(from: "9:35")!, room: 120, week: nil),
            ScheduleItem(subject: "Алгебра и геометрия", startTime: formatter.date(from: "9:50")!,
                         endTime: formatter.date(from: "11:25")!, room: 212, week: nil),
            ScheduleItem(subject: "Дифференциальные уравнения", startTime: formatter.date(from: "11:55")!,
                         endTime: formatter.date(from: "13:30")!, room: 325, week: nil)
        ];
    }()
}

struct ScheduleItem {
    let subject: String
    let startTime: Date
    let endTime: Date
    let room: Int
    let week: Schedule.Week?
    //let simulatious: Bool
}

struct lesson {
    let subject: String
    let teacher: String
    let room: Int
}
