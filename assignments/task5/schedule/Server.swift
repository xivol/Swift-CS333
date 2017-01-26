//
//  Server.swift
//  schedule
//
//  Created by Илья Лошкарёв on 25.01.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import Foundation

class Server {

    static let endpoint = ""
    static let APIKey = ""
    
    class func path(to entity:String, withId id: String? = nil) -> URL {
        var base = URLComponents(string:endpoint)!
        return base.url!
        
    }
}
