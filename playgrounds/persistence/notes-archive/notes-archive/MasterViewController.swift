//
//  MasterViewController.swift
//  notes-archive
//
//  Created by Илья Лошкарёв on 18.03.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    
    var notes = [Note]() {
        didSet {
            // Update reference
            if let app = UIApplication.shared.delegate as? AppDelegate {
                app.storage = notes as NSCoding
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        // Unarchive from file
        if let app = UIApplication.shared.delegate as? AppDelegate {
            notes = app.unarchiveStorage(atPath: nil) as! [Note] // strong reference
            app.storage = notes as NSCoding
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    func insertNewObject(_ sender: Any) {
        
        let input = UIAlertController(title: "New Note", message: "", preferredStyle: .alert)
        input.addTextField {
            textField in
            textField.placeholder = "What's up?"
        }
        
        let ok = UIAlertAction(title: "OK", style: .default) {
            [weak input, weak self] action in
            if let text = input?.textFields?.first?.text {
                let note = Note(content: text)
                self?.notes.insert(note, at: 0)
                let indexPath = IndexPath(row: 0, section: 0)
                self?.tableView.insertRows(at: [indexPath], with: .automatic)
            } else {
                print("no valid input")
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        input.addAction(cancel)
        input.addAction(ok)
        
        present(input, animated: true)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let note = notes[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = note
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let note = notes[indexPath.row]
        cell.textLabel!.text = note.content
        cell.detailTextLabel!.text = Note.dateFormatter.string(from: note.date)
        cell.backgroundColor = note.color
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
            print("insert")
        }
    }


}

