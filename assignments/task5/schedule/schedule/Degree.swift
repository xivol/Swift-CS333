//
//  Degree.swift
//  schedule
//
//  Created by Илья Лошкарёв on 20.01.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import Foundation

public enum Degree: Int16, CustomStringConvertible {
    case bachelor = 1, master = 2, postgraduate = 3
    
    public var description: String {
        get {
            switch self {
            case .bachelor:
                return "Бакалавриат"
            case .master:
                return "Магистратура"
            case .postgraduate:
                return "Аспирантура"
            }
        }
    }
    
    public static var all: [Degree] {
        get { return [.bachelor, .master, .postgraduate] }
    }
}
