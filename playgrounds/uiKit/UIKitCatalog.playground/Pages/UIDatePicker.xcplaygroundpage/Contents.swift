import UIKit
import PlaygroundSupport

class Handler {
    let label: UILabel!
    @objc func datePicked(sender: UIDatePicker) {
        let formatter = DateFormatter()
        if sender.datePickerMode == .time {
            formatter.dateFormat = "HH:mm:ss"
        } else {
            formatter.dateFormat = "dd.MM.yyyy"
        }
        label.text = formatter.string(from: sender.date)
    }
    
    init(with label: UILabel){
        self.label = label
    }
}

let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
containerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)


let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 250, height: 100))
datePicker.datePickerMode = .date
datePicker.setValue(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), forKeyPath: "textColor") // KVC!?
datePicker.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
containerView.addSubview(datePicker)

let timePicker = UIDatePicker(frame: CGRect(x: 0, y: 100, width: 250, height: 100))
timePicker.datePickerMode = .time
timePicker.locale = Locale(identifier: "ru_Ru")
timePicker.timeZone = TimeZone(identifier: "GMT+3")
containerView.addSubview(timePicker)

let displayLabel = UILabel(frame: CGRect(x: 0, y: 200, width: 250, height: 50))
displayLabel.textAlignment = .center
containerView.addSubview(displayLabel)

let handler = Handler(with: displayLabel)
datePicker.addTarget(handler, action: #selector(Handler.datePicked(sender:)), for: .valueChanged)
timePicker.addTarget(handler, action: #selector(Handler.datePicked(sender:)), for: .valueChanged)

PlaygroundPage.current.liveView = containerView
