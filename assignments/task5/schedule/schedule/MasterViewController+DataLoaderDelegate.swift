//
//  MasterViewController+DataLoaderDelegate.swift
//  schedule
//
//  Created by Илья Лошкарёв on 30.03.17.
//  Copyright © 2017 mmcs. All rights reserved.
//

import UIKit

extension MasterViewController: DataLoaderDelegate {

    func dataLoader(_ dataLoader: DataLoader, didFinishLoadingWith data: Any?) {
        switch dataLoader {
        case is TimetableDataLoader:
            guard let loadedTimetable = data as? Timetable else {
                fatalError("unexpected data")
            }
            
            self.timetable = loadedTimetable
            if self.currentWeek != nil {
                self.timetable!.currentWeek = self.currentWeek!
            }
            
            if let activity = tableView.backgroundView as? UIActivityIndicatorView {
                activity.removeFromSuperview()
                activity.stopAnimating()
            }
            
            tableView.reloadData()
            
        case is WeekDataLoader:
            guard let loadedWeek = data as? AlternatingWeek else {
                fatalError("unexpected data")
            }
            
            self.currentWeek = loadedWeek
            if self.timetable != nil{
                self.timetable!.currentWeek = loadedWeek
                tableView.reloadData()
            }
        default:
            fatalError("unexpected loader")
        }
    }
    
    func dataLoader(_ dataLoader: DataLoader, didFinishLoadingWith error: NSError) {
        let alert = UIAlertController(title: "Error", message: error.description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated:  true)
    }
}

