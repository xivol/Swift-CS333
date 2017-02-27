import UIKit
import PlaygroundSupport

class Model: NSObject, UITableViewDataSource {
    var data = [[String]]()
    var titles = [String]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // try diferrent UITableViewCellStyles!
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "")
        
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < titles.count {
            return titles[section]
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            data[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else {
            data[indexPath.section].insert("🍍 Pineapple", at: indexPath.row + 1)
            tableView.insertRows(at: [IndexPath(row: indexPath.row + 1, section: indexPath.section)], with: .automatic)
        }
        tableView.setEditing(false, animated: true)
    }

}

class Controller: NSObject, UITableViewDelegate {
    
    let label: UILabel!
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dataSource = tableView.dataSource as? Model else {
            print("Wrong data source!")
            PlaygroundPage.current.finishExecution()
        }
        label.text = dataSource.data[indexPath.section][indexPath.row]
    }
    
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
    
    init(with label: UILabel) {
        self.label = label
    }
}

let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 250, height: 500), style: .grouped)
tableView.bounces = false

let dataSource = Model()
tableView.dataSource = dataSource
dataSource.titles.append("Fruits")
dataSource.data.append(["🍎 Delicious Apples", "🍊 Oranges", "🍌 Bananas"])
dataSource.titles.append("Vegetables")
dataSource.data.append(["🥔 Potatoes", "🍅 Tomatoes", "🥕 Crunchy Carrots"])

let displayLabel = UILabel(frame: CGRect(x: 0, y: 400, width: 250, height: 100))
tableView.addSubview(displayLabel)
displayLabel.textAlignment = .center

let delegate = Controller(with: displayLabel)
tableView.delegate = delegate

PlaygroundPage.current.liveView = tableView
tableView.setEditing(true, animated: true)