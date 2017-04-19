//
//  Date+Compare.swift
//  track-my-steps
//
//  Created by Илья Лошкарёв on 18.04.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//
//  Date comparision up to seconds

import Foundation
extension Date {
    static func > (_ first: Date, _ second: Date) -> Bool {
        return Calendar.current.compare(first, to: second,
                                        toGranularity: Calendar.Component.second) == ComparisonResult.orderedDescending
    }
    
    static func < (_ first: Date, _ second: Date) -> Bool {
        return Calendar.current.compare(first, to: second,
                                        toGranularity: Calendar.Component.second) == ComparisonResult.orderedAscending
    }
    
    static func == (_ first: Date, _ second: Date) -> Bool {
        return Calendar.current.compare(first, to: second,
                                        toGranularity: Calendar.Component.second) == ComparisonResult.orderedSame
    }
}
