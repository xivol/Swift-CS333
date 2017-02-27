import UIKit
import PlaygroundSupport

class RGBPicker: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: UIPickerViewDataSource
    
    var data = [[Int]]()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return data.count
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data[component].count
    }
    
    // MARK: UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = "\(data[component][row])"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        switch component {
        case 0:
            label.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        case 1:
            label.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        case 2:
            label.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        default:
            break
        }
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard pickerView.dataSource === self else {
            PlaygroundPage.current.finishExecution()
        }
        label.backgroundColor = pickedColor(in: pickerView)
    }
    
    func pickedColor(in view: UIPickerView) -> UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        for component in 0..<numberOfComponents(in: view) {
            let intValue = data[component][view.selectedRow(inComponent: component)]
            let value = CGFloat(intValue) / CGFloat(data[component].last!)
            switch component {
            case 0:
                red = value
            case 1:
                green = value
            case 2:
                blue = value
            default:
                break
            }
        }
        return UIColor(displayP3Red: red, green: green, blue: blue, alpha: 1)
    }
    
    let label: UILabel!
    
    init(with label: UILabel){
        self.label = label
        data.append([Int](0...255))
        data.append([Int](0...255))
        data.append([Int](0...255))
    }
}

let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 300, height: 150))
let colorLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 10))

let dataSource = RGBPicker(with: colorLabel)
pickerView.delegate = dataSource
pickerView.dataSource = dataSource
pickerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
pickerView.addSubview(colorLabel)

pickerView.selectRow(255, inComponent: 0, animated: false)
pickerView.selectRow(255, inComponent: 1, animated: false)
pickerView.selectRow(255, inComponent: 2, animated: false)

PlaygroundPage.current.liveView = pickerView
