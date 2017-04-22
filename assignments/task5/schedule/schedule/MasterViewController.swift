//
//  MasterViewController.swift
//  schedule
//
//  Created by mmcs on 28.03.17.
//  Copyright © 2017 mmcs. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    
    var timetableLoader = TimetableDataLoader(forGroup: 48)
    var weekLoader = WeekDataLoader()
    
    var timetable: Timetable? = nil
    var currentWeek: AlternatingWeek? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        timetableLoader.delegate = self
        weekLoader.delegate = self
        Connection.request {
            self.timetableLoader.loadData()
            self.weekLoader.loadData()
        }

        let activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        tableView.backgroundView = activity
        activity.hidesWhenStopped = true
        activity.startAnimating()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let current = timetable?.current?[indexPath.section]
                let timeslot = current?[indexPath.row]
                
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = timeslot
                
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View Controller

    override func numberOfSections(in tableView: UITableView) -> Int {
            return timetable != nil ? 6 : 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Locale.current.calendar.weekdaySymbols[section + 1]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let current = timetable?.current?[section]
        return current?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let current = timetable?.current?[indexPath.section]
        else { return UITableViewCell.defaultHeight }
        return CGFloat(current[indexPath.row].lessons.count) * UITableViewCell.defaultHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stackCell = tableView.dequeueReusableCell(withIdentifier: "StackCell", for: indexPath) as! TableViewCell
        let current = timetable?.current?[indexPath.section]
        configureCell(stackCell, with: current?[indexPath.row])
        return stackCell
    }
    
    func configureCell(_ cell: TableViewCell, with data: Timeslot?) {
        for view in cell.stack.arrangedSubviews {
            cell.stack.removeArrangedSubview(view)
        }
        
        if let timeslot = data {
            for lesson in timeslot.lessons {
                let subCell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                if lesson.subject.characters.count > 20 && lesson.abbreviation.characters.count > 0 {
                    subCell.textLabel!.text = lesson.abbreviation
                } else {
                    subCell.textLabel!.text = lesson.subject
                }
                subCell.detailTextLabel!.text = lesson.room + " " + lesson.teacher
                subCell.isUserInteractionEnabled = false
                cell.stack.addArrangedSubview(subCell)
            }
            
            cell.isUserInteractionEnabled = true
            cell.accessoryType = .disclosureIndicator
            
            cell.timeLabel!.text = Timeslot.outputTimeFormatter.string(from: timeslot.startTime.date!) +
                "\n" + Timeslot.outputTimeFormatter.string(from: timeslot.endTime.date!)
        } else {
            cell.isUserInteractionEnabled = false
            cell.accessoryType = .none
            cell.timeLabel!.text = ""
        }
        
    }
}

