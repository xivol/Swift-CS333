//
//  PicturesController.swift
//  apod-viewer
//
//  Created by Илья Лошкарёв on 18.04.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PicturesController: NSFetchedResultsController<Picture>, UICollectionViewDataSource {
    
    static let examples =
                   [ (title: "Swift 1", subtitle: "", date: "01.04.2017", path: "swift3"),
                     (title: "Swift 2", subtitle: "", date: "02.04.2017", path: "swift2"),
                     (title: "Cat 1",   subtitle: "", date: "03.04.2017", path: "cat1"),
                     (title: "Cat 2",   subtitle: "", date: "04.04.2017", path: "cat2") ]
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections?[section].numberOfObjects ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewController.reuseIdentifier, for: indexPath) as? CollectionViewCell else {
            fatalError("Wrong Cell Reuse Identifier")
        }
        
        if let picture = sections?[indexPath.section].objects?[indexPath.row] as? Picture {
            cell.imageView.image = UIImage(imageLiteralResourceName: picture.source!)
            cell.titleLabel.text = picture.title
        }
        
        return cell
    }
}
