//
//  DataLoader.swift
//  schedule
//
//  Created by Илья Лошкарёв on 30.03.17.
//  Copyright © 2017 mmcs. All rights reserved.
//

import Foundation
import UIKit

protocol DataLoader: class {
    func loadData()
    var source: URL { get }
    weak var delegate: DataLoaderDelegate? { get set }
}

protocol DataLoaderDelegate: class {
    func dataLoader(_ dataLoader: DataLoader, didFinishLoadingWith data: Any?)
    func dataLoader(_ dataLoader: DataLoader, didFinishLoadingWith error: NSError)
}

class JSONDataLoader<T>: DataLoader {
    let source: URL
    weak var delegate: DataLoaderDelegate?
    
    private(set) var parsedData: T? = nil
    
    init(with url: URL) {
        source = url
    }
    
    func errorFor(response: URLResponse?, with data: Data?, error: Error?) -> NSError? {
        if let error = error as? NSError {
            return error
        }
        guard data != nil else {
            return NSError(domain: "Empty Response", code: 0, userInfo: ["response": response as Any])
        }
        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
        else {
            return NSError(domain: "Unexpected Response", code: 0, userInfo: ["response": response as Any])
        }
        
        return nil
    }
    
    func loadData() {
        let task = URLSession.shared.dataTask(with: source) {
            (data, response, error) in
            if let error = self.errorFor(response: response, with: data, error: error) {
                DispatchQueue.main.async {
                    self.delegate?.dataLoader(self, didFinishLoadingWith: error)
                }
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                self.parsedData = try self.parseJSON(json)
                DispatchQueue.main.async {
                    self.delegate?.dataLoader(self, didFinishLoadingWith: self.parsedData)
                }
            } catch let error as NSError {
                DispatchQueue.main.async {
                    self.delegate?.dataLoader(self, didFinishLoadingWith: error)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(_ json: [String : Any] ) throws -> T {
        let typename = String(describing: T.self)
        guard let result = json[typename] as? T else {
            throw NSError(domain: "JSON Error", code: 0, userInfo: ["json" : json])
        }
        return result
    }
}
