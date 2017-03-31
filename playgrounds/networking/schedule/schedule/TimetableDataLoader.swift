//
//  LessonDataLoader.swift
//  schedule
//
//  Created by mmcs on 28.03.17.
//  Copyright © 2017 mmcs. All rights reserved.
//

import Foundation

class TimetableDataLoader: JSONDataLoader<Timetable> {
    let group: Int?
    
    init(forGroup group: Int) {
        self.group = group
        super.init(with: URL(string: "http://users.mmcs.sfedu.ru:3001/APIv1/schedule/group/\(group)?APIKey=undefined")!)
    }
    
    override func parseJSON(_ json: [String : Any]) throws -> Timetable  {
        guard
            let lessons = json["lessons"] as? [[String:Any]],
            let curricula = json["curricula"] as? [[String:Any]]
        else {
            throw NSError(domain: "JSON Error", code: 0, userInfo: ["json" : json])
        }
        
        var timeslots = [Int : Timeslot]()
        
        for lesson in lessons {
            timeslots[lesson["id"] as! Int] = Timeslot(lesson["timeslot"] as! String)
        }
        
        //print(timeslots)
        
        var result = Set<Timeslot>()
        for item in curricula {
            let timeslot = timeslots[item["lessonid"] as! Int]!
            let lesson = Lesson(subject: item["subjectname"] as! String,
                                abbreviation: item["subjectabbr"] as! String,
                                teacher: item["teachername"] as! String,
                                teacherDegree: item["teacherdegree"] as! String,
                                room: item["roomname"] as! String)
            
            timeslot.lessons.append(lesson)

            result.insert(timeslot)
        }

        return Timetable(with: [Timeslot](result))
    }

}
