//
//  ViewController.swift
//  stopwatch
//
//  Created by Илья Лошкарёв on 21.02.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit

class ViewController: UIViewController, StopwatchDelegate {

    weak var stopwatch: Stopwatch?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopwatch = (UIApplication.shared.delegate as! AppDelegate).stopwatch
        stopwatch!.delegate = self
        
        let button = UIButton(type: .custom)
        button.frame = view.bounds
        button.titleLabel?.frame = button.bounds
        button.titleLabel?.font = button.titleLabel?.font.withSize( view.bounds.width / 6)
        button.titleLabel?.textAlignment = .justified
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(stopwatchTouch), for: .touchUpInside)
        
        view = button
        view.backgroundColor = UIColor.gray
        updateTime(0, 0, 0)
    }
    
    func stopwatchTouch() {
        if stopwatch!.isRunning {
            view.backgroundColor = UIColor.gray
            stopwatch!.stop()
        } else {
            view.backgroundColor = UIColor.orange
            stopwatch!.start()
        }
    }
    
    func stopwatchDidStart(stopwatch: Stopwatch) {
        print("stopwatch has started")
    }
    
    func stopwatchDidStop(stopwatch: Stopwatch) {
        print("stopwatch has stoped")
        updateTime(0, 0, 0)
    }
    
    func stopwatchDidPause(stopwatch: Stopwatch, at time: TimeInterval) {
        print("stopwatch has paused at \(time)")
        view.backgroundColor = UIColor.red
    }
    
    func stopwatchDidResume(stopwatch: Stopwatch, at time: TimeInterval) {
        print("stopwatch has resumed at \(time)")
        view.backgroundColor = UIColor.orange
    }
    
    func stopwatchTimeChanged(stopwatch: Stopwatch, elapsedTime: TimeInterval) {
        let minutes = UInt(elapsedTime / 60)
        let seconds = UInt(elapsedTime - TimeInterval(minutes * 60))
        let milliseconds = UInt((elapsedTime - TimeInterval(minutes * 60 + seconds)) * 100)
        updateTime(minutes, seconds, milliseconds)
        
        if minutes >= 100 {
            stopwatch.stop()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        stopwatch?.stop()
    }
    
    func updateTime(_ minutes: UInt, _ seconds: UInt, _ milliseconds: UInt) {
        if let button = view as? UIButton {
            button.setTitle(String(format:"%02d:%02d:%02d", minutes, seconds, milliseconds), for: .normal)
        }
    }


}

