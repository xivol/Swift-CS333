//
//  FiltersTableViewController.swift
//  improcessor
//
//  Created by Илья Лошкарёв on 10.03.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit

class FiltersTableViewController: UITableViewController {
    var filterList = FilterList()
    var setFilter: ((String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = filterList
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setFilter?(filterList[indexPath.section, indexPath.row])
        if let navigation = parent as? UINavigationController {
            navigation.popViewController(animated: true)
        }
    }
}
