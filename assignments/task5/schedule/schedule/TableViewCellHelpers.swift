//
//  TableViewCellHelpers.swift
//  schedule
//
//  Created by Илья Лошкарёв on 20.01.17.
//  based on
//  https://medium.com/p/ios-cell-registration-reusing-with-swift-protocol-extensions-and-generics-c5ac4fb5b75e
//  by 

import Foundation
import UIKit

//
//  MARK: Reusable View
//

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: ReusableView {
}

//
//  MARK: Xib Loadable View
//

protocol XibLoadableView: class {
    static var xibName: String { get }
}

extension XibLoadableView where Self: UIView {
    static var xibName: String {
        return String(describing: Self.self)
    }
}

//
//  MARK: UITableView ReusableView registration
//

extension UITableView {
    
    // ReusableView Registration
    // for code only TableViewCells
    
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    // XibLoadableView Registration
    // for xib based TableViewCells
    
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView, T: XibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.xibName, bundle: bundle)
        
        register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    // Generic dequeueReusableCellWithIdentifier
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return cell
    }
}
