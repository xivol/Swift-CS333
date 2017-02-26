import UIKit
import PlaygroundSupport

let label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 250))

label.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
label.text = "Hello Label!"
label.textColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
label.shadowColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
label.textAlignment = .center
label.font = UIFont(name: "AmericanTypewriter", size: 32)
// for other font names visit http://iosfonts.com/



PlaygroundPage.current.liveView = label
