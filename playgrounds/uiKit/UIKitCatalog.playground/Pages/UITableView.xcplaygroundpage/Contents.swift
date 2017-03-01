//: # UITableView
//: Displays hierarchical lists of information and supports selection and editing of the information.
//:
//: [Table View API Reference](https://developer.apple.com/reference/uikit/uitableview)
import UIKit
import PlaygroundSupport

class Model: NSObject, UITableViewDataSource {
    let cellReuseIdentifier = "Cell"
    var data = [[String]]()
    var titles = [String]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    // MARK: Cells
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create new cell
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellReuseIdentifier)
        // or REUSE existing cell that is out of sight
        //let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        // add Accessories
        cell.accessoryType = .none
        // Populate cell
        let components = (data[indexPath.section][indexPath.row]).components(separatedBy: " ")
        cell.imageView?.image = components[0].image
        if components.count > 2 {
            cell.textLabel?.text = components[2]
            cell.detailTextLabel?.text = components[1]
        } else {
            cell.textLabel?.text = components[1]
        }
        return cell
    }
    
    // MARK: Section Headers and Footers
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section < titles.count else {
            return nil
        }
        return titles[section]
    }
    
    //: MARK: Editing
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            data[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else {
            data[indexPath.section].insert("🍍 Fancy Pineapples", at: indexPath.row + 1)
            tableView.insertRows(at: [IndexPath(row: indexPath.row + 1, section: indexPath.section)], with: .automatic)
        }
        tableView.setEditing(false, animated: true)
    }

}

class Controller: NSObject, UITableViewDelegate {
    
    let label: UILabel!
    init(with label: UILabel) {
        self.label = label
    }
    
    // MARK: Row Selection
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dataSource = tableView.dataSource as? Model else {
            print("Wrong data source!")
            PlaygroundPage.current.finishExecution()
        }
        label.text = dataSource.data[indexPath.section][indexPath.row]
    }
    
    // MARK: Editing
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        switch indexPath.section {
        case 0:
            return .insert
        default:
            return .delete
        }
    }
}
//: ### Initialize Table View
let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 250, height: 500), style: .grouped)
tableView.bounces = false
//: ### Initialize Data
let dataSource = Model()
dataSource.titles.append("Fruits")
dataSource.data.append(["🍎 Delicious Apples", "🍊 Oranges", "🍌 Bananas"])
dataSource.titles.append("Vegetables")
dataSource.data.append(["🥔 Potatoes", "🍅 Tomatoes", "🥕 Crunchy Carrots"])
//: Register reusable cell class
tableView.register(UITableViewCell.self, forCellReuseIdentifier: dataSource.cellReuseIdentifier)
tableView.dataSource = dataSource
//: ### Initialize Controller
let displayLabel = UILabel(frame: CGRect(x: 0, y: 400, width: 250, height: 100))
tableView.addSubview(displayLabel)
displayLabel.textAlignment = .center

let delegate = Controller(with: displayLabel)
tableView.delegate = delegate

PlaygroundPage.current.liveView = tableView
tableView.setEditing(true, animated: true)
