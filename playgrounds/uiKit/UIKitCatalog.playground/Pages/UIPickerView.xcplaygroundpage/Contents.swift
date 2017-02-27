import UIKit
import PlaygroundSupport

class Model: NSObject, UIPickerViewDataSource {
    var data = [[String]]()
    let fakeRowCount = 10_000
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fakeRowCount // data[component].count
    }
    
    func data(forRow row: Int, inComponent component: Int) -> String {
        return data[component][row % data[component].count]
    }
}

class Controller: NSObject, UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let dataSource =  pickerView.dataSource as? Model else {
            print("Wrong model!")
            PlaygroundPage.current.finishExecution()
        }
        return dataSource.data(forRow: row, inComponent: component)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let dataSource =  pickerView.dataSource as? Model else {
            print("Wrong model!")
            PlaygroundPage.current.finishExecution()
        }
        
        let items = [ dataSource.data(forRow: pickerView.selectedRow(inComponent: 0), inComponent: 0),
                      dataSource.data(forRow: pickerView.selectedRow(inComponent: 1), inComponent: 1),
                      dataSource.data(forRow: pickerView.selectedRow(inComponent: 2), inComponent: 2)]
        if items[0] == items[1] && items[1] == items[2] {
            let win = UILabel(frame: pickerView.frame)
            win.text = "WIN!!!"
            win.textAlignment = .center
            win.font = UIFont(name: "Chalkduster", size: 48)
            win.textColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
            pickerView.addSubview(win)
            // show and hide
            win.alpha = 0
            UIView.animate(withDuration: 0.5){ win.alpha = 1 }
            UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveLinear, animations: { win.alpha = 0 }, completion: { _ in win.removeFromSuperview() })
        }
    }
}

let slotView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 300, height: 150))

let slots = Model()
slots.data.append(["⭐️","⚡️","🐸","🌈","🍎"])
slots.data.append(["⚡️","⭐️","🌈","🍎","🐸"])
slots.data.append(["🍎","🌈","⭐️","🐸","⚡️"])

slotView.dataSource = slots
let delegate = Controller()
slotView.delegate = delegate

slotView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
PlaygroundPage.current.liveView = slotView

slotView.selectRow(1000, inComponent: 0, animated: true)
slotView.selectRow(1000, inComponent: 1, animated: true)
slotView.selectRow(1000, inComponent: 2, animated: true)