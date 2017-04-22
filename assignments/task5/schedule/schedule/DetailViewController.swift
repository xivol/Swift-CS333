//
//  DetailViewController.swift
//  schedule
//
//  Created by mmcs on 28.03.17.
//  Copyright © 2017 mmcs. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    func configureView() {
        guard let detail = self.detailItem else { return }
        
        timeLabel?.text = Timeslot.outputTimeFormatter.string(from: detail.startTime.date!) + " - " +
            Timeslot.outputTimeFormatter.string(from: detail.endTime.date!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }

    var detailItem: Timeslot? {
        didSet {
            self.configureView()
        }
    }

    // MARK: - Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailItem?.lessons.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DetailTableViewCell
        
        cell.titleLabel.text = detailItem!.lessons[indexPath.row].subject
        cell.smallDetail.text = detailItem!.lessons[indexPath.row].room
        cell.largeDetail.text = detailItem!.lessons[indexPath.row].teacher

        return cell
    }
}

