//
//  ViewController.swift
//  track-my-steps
//
//  Created by Илья Лошкарёв on 13.04.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: TimeLabel!
    @IBOutlet weak var pause: UIButton!
    @IBOutlet weak var stop: UIButton!
    
    unowned var trackManager = (UIApplication.shared.delegate as! AppDelegate).trackManager
    
    let stopwatch = Stopwatch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopwatch.delegate = timeLabel
        stopwatch.start()
        pause.layer.borderColor = pause.tintColor.cgColor
        pause.layer.borderWidth = 5
    }
    
    @IBAction func playPause(_ sender: UIButton) {
        if trackManager.isRunning {
            trackManager.pause()
            stopwatch.pause()
            pause.setTitle("Resume", for: .normal)
            pause.tintColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            print("pause")
        } else {
            trackManager.resume()
            stopwatch.resume()
            pause.setTitle("Pause", for: .normal)
            pause.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            print("play")
        }
    }

    @IBAction func stopTracking(_ sender: UIButton) {
        trackManager.stop()
        stopwatch.stop()
        dismiss(animated: true)
    }

}

class RoundButton: UIButton {
    override var tintColor: UIColor! {
        didSet {
            layer.borderColor = tintColor.cgColor
        }
    }
    
    override var bounds: CGRect {
        didSet {
            layer.cornerRadius = bounds.width / 2
        }
    }
}


class TimeLabel: UILabel, StopwatchDelegate {
    func stopwatchDidStart(stopwatch: Stopwatch) {
        updateTime(0, 0, 0)
    }
    
    func stopwatchDidStop(stopwatch: Stopwatch) {}
    func stopwatchDidPause(stopwatch: Stopwatch, at time: TimeInterval) {}
    func stopwatchDidResume(stopwatch: Stopwatch, at time: TimeInterval) {}
    
    func stopwatchTimeChanged(stopwatch: Stopwatch, elapsedTime: TimeInterval) {
        let minutes = UInt(elapsedTime / 60)
        let seconds = UInt(elapsedTime - TimeInterval(minutes * 60))
        let milliseconds = UInt((elapsedTime - TimeInterval(minutes * 60 + seconds)) * 100)
        updateTime(minutes, seconds, milliseconds)
    }
    
    func updateTime(_ minutes: UInt, _ seconds: UInt, _ milliseconds: UInt) {
        let formatted = String(format:"%02d:%02d:%02d", minutes, seconds, milliseconds)
        let attributed = NSAttributedString(string: formatted, attributes: [
            NSKernAttributeName : CGFloat(4) ])
        self.attributedText = attributed
    }
}
