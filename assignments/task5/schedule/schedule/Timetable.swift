//
//  Timetable.swift
//  schedule
//
//  Created by Илья Лошкарёв on 29.03.17.
//  Copyright © 2017 mmcs. All rights reserved.
//

import Foundation

class Timetable {
    private(set) var full: [Int: [Timeslot]]
    
    private(set) var current: [Int:[Timeslot]]? = nil
    
    var currentWeek: AlternatingWeek = .full {
        didSet {
            recalcTimetableForCurrentWeek()
        }
    }
    
    init(with timeslots: [Timeslot]) {
        full = [Int : [Timeslot]]()
        
        for timeslot in timeslots {
            if full[timeslot.weekday] == nil {
                full[timeslot.weekday] = [Timeslot]()
            }
            full[timeslot.weekday]?.append(timeslot)
        }
        
        for day in full.keys {
            full[day]?.sort {$0.startTime.hour! < $1.startTime.hour!}
        }
    }
    
    private func recalcTimetableForCurrentWeek() {
        current = [Int : [Timeslot]]()
        for day in full.keys {
            current![day] = full[day]?.filter({ $0.alternating == .full || $0.alternating == currentWeek })
        }
    }
}
