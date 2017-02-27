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

}

class Controller: NSObject, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dataSource = tableView.dataSource as? Model else {
            print("Wrong data source!")
            PlaygroundPage.current.finishExecution()
        }
        print(dataSource.data[indexPath.section][indexPath.row])
    }
}

let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 250, height: 500), style: .grouped)
let dataSource = Model()
dataSource.titles.append("Fruits")
dataSource.data.append(["🍎 Delicious Apples", "🍊 Oranges", "🍌 Bananas"])
dataSource.titles.append("Vegetables")
dataSource.data.append(["🥔 Scumptios Potatoes", "🍅 Tomatoes", "🥕 Carrots"])
let delegate = Controller()
tableView.delegate = delegate
tableView.dataSource = dataSource

PlaygroundPage.current.liveView = tableView