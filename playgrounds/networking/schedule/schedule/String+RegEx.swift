//
//  String+RegEx.swift
//  schedule
//
//  Created by mmcs on 29.03.17.
//  Copyright © 2017 mmcs. All rights reserved.
//
import Foundation

extension String {
    func matches(forPattern pattern: String, withOptions op: NSRegularExpression.Options = .anchorsMatchLines) -> [[String]]? {
        guard let ex = try? NSRegularExpression(pattern: pattern, options: op)
            else { return nil }
        let matches = ex.matches(in: self, options: .anchored, range: NSRange(0..<Int(self.characters.count)))
        guard matches.count > 0 else { return nil }
        
        var result = [[String]]()
        for match in matches {
            var groupMatch = [String]()
            for i in 0...ex.numberOfCaptureGroups {
                let textRange = match.rangeAt(i)
                let start = self.index(startIndex, offsetBy: textRange.location)
                let end = self.index(start, offsetBy: textRange.length, limitedBy: self.endIndex)
                groupMatch.append(self.substring(with: start..<end!))
            }
            result.append(groupMatch)
        }
        return result
    }
}
