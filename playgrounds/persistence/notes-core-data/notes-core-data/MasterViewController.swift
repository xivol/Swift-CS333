//
//  MasterViewController.swift
//  notes-core-data
//
//  Created by Илья Лошкарёв on 22.03.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var detailViewController: DetailViewController? = nil
    var fetchController : NSFetchedResultsController<Note>!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        // Button setup
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        // Split View Controller
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        // Fetched Results Controller
        fetchController =  Note.fetchResults(for: Note.fetchRequest(),
                                             withDelegate: self as NSFetchedResultsControllerDelegate)
        do {
            try fetchController.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Fetch error \(nserror), \(nserror.userInfo)")
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
            [weak input] action in
            if let text = input?.textFields?.first?.text {
                let _ = Note(content: text)
                // CoreDataContainer.saveContext()
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
            let object = self.fetchController.object(at: indexPath)
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchController.sections![section]
        return sectionInfo.numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let note = self.fetchController.object(at: indexPath)
        self.configureCell(cell, withData: note)
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataContainer.context.delete(self.fetchController.object(at: indexPath))
            // CoreDataContainer.saveContext()
        }
    }

    func configureCell(_ cell: UITableViewCell, withData data: Note) {
        cell.textLabel!.text = data.content!
        cell.detailTextLabel!.text = Note.dateFormatter.string(from: data.date as! Date)
        cell.backgroundColor = data.color!
    }

    // MARK: - Fetched Results Controller
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            self.tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .insert:
            self.tableView.insertRows(at: [newIndexPath!], with: .left)
        case .update:
            configureCell(self.tableView.cellForRow(at: indexPath!)!, withData: anObject as! Note)
        case .move:
            self.tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }

}

