//
//  FilterList.swift
//  improcessor
//
//  Created by Илья Лошкарёв on 10.03.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit


class FilterList: NSObject, UITableViewDataSource {
    var filters = [String:[String]]()
   
    override init(){
        for category in [kCICategoryBlur, kCICategoryStylize, kCICategoryColorEffect, kCICategoryDistortionEffect] {
            filters[category] = CIFilter.filterNames(inCategory: category)
            //print(filters[category])
        }
    }
    
    init (category: String) {
        filters[category] =  CIFilter.filterNames(inCategory: category)
    }
    
    subscript(section: Int, row: Int) -> String {
        let indexOfSection = filters.index(filters.startIndex, offsetBy: section)
        return filters[indexOfSection].value[row]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filters.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let indexOfSection = filters.index(filters.startIndex, offsetBy: section)
        return filters[indexOfSection].value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let indexOfSection = filters.index(filters.startIndex, offsetBy: indexPath.section)
        
        var title = filters[indexOfSection].value[indexPath.row]
        title.removeSubrange(title.startIndex...title.index(title.startIndex, offsetBy: 1))
        cell.textLabel?.text = title.replacingOccurrences(of: "([a-z])([A-Z])", with: "$1 $2", options: .regularExpression, range: nil)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let indexOfSection = filters.index(filters.startIndex, offsetBy: section)
        var sectionTitle = filters[indexOfSection].key
        sectionTitle.removeSubrange(sectionTitle.range(of: "CICategory")!)
        return sectionTitle
    }
}
