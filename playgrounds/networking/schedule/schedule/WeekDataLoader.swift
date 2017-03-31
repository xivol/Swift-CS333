//
//  WeekDataLoader.swift
//  schedule
//
//  Created by mmcs on 29.03.17.
//  Copyright © 2017 mmcs. All rights reserved.
//

import Foundation

class WeekDataLoader: JSONDataLoader<AlternatingWeek> {
    init() {
        super.init(with: URL(string: "http://users.mmcs.sfedu.ru:3001/APIv1/week?APIKey=undefined")!)
    }
    
    override func parseJSON(_ json: [String : Any]) throws -> AlternatingWeek  {
        guard
            let weekID = json["week"] as? Int,
            let result = AlternatingWeek(id: weekID)
        else {
            throw NSError(domain: "JSON Error", code: 0, userInfo: ["json" : json])
        }
        return result
    }
}
