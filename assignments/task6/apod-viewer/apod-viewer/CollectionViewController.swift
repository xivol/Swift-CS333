//
//  CollectionViewController.swift
//  apod-viewer
//
//  Created by Илья Лошкарёв on 18.04.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit
import CoreData



class CollectionViewController: UICollectionViewController, NSFetchedResultsControllerDelegate {
    static let reuseIdentifier = "Cell"
    var picturesController: PicturesController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.picturesController = Picture.controller(for: Picture.fetchRequest(), withDelegate: self)
        self.collectionView?.dataSource = picturesController
        try! picturesController.performFetch()
        
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy"
        
        for (title,subtitle,date,path) in PicturesController.examples {
            let _ = Picture(title: title, subtitle: subtitle, date: df.date(from: date)!, source: path)
        }
        
        collectionView?.allowsSelection = true
    }

    // MARK: NSFetchedResultsControllerDelegate
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        collectionView?.reloadData()
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController,
            let indexPath = collectionView?.indexPathsForSelectedItems?[0] {
            destination.detailItem = picturesController.sections?[indexPath.section].objects?[indexPath.row] as? Picture
        }
    }
 

}
