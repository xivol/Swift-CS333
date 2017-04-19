//
//  Stopwatch.swift
//  stopwatch
//
//  Created by Илья Лошкарёв on 21.02.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import Foundation

protocol StopwatchDelegate: class {
    func stopwatchDidStart(stopwatch: Stopwatch)
    func stopwatchDidStop(stopwatch: Stopwatch)
    func stopwatchDidPause(stopwatch: Stopwatch, at time: TimeInterval)
    func stopwatchDidResume(stopwatch: Stopwatch, at time: TimeInterval)
    func stopwatchTimeChanged(stopwatch: Stopwatch, elapsedTime: TimeInterval)
}

class Stopwatch {
    
    var delegate: StopwatchDelegate?

    private var timer: Timer?
    private var startTime: TimeInterval!
    private var paused = false
    private var pauseStarted: TimeInterval?
    private var pausedTime: TimeInterval!
    
    private(set) var elapsedTime: TimeInterval = 0
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true)
        {  [weak self](t) in
            self?.update()
        }
        startTime = Date.timeIntervalSinceReferenceDate
        pausedTime = 0
        delegate?.stopwatchDidStart(stopwatch: self)
    }
    
    func stop() {
        timer?.invalidate()
        delegate?.stopwatchDidStop(stopwatch: self)
    }
    
    func pause() {
        guard isRunning else { return }
        paused = true
        let currentTime = Date.timeIntervalSinceReferenceDate
        pauseStarted = currentTime - startTime
        delegate?.stopwatchDidPause(stopwatch: self, at: pauseStarted!)
    }
    
    func resume() {
        guard isPaused else { return }
        paused = false
        let currentTime = Date.timeIntervalSinceReferenceDate
        pausedTime! += currentTime - pauseStarted! - startTime
        delegate?.stopwatchDidResume(stopwatch: self, at: currentTime - startTime)
    }
    
    private func update() {
        guard isRunning, !isPaused else { return }
        let currentTime = Date.timeIntervalSinceReferenceDate
        elapsedTime = currentTime - startTime - pausedTime
        delegate?.stopwatchTimeChanged(stopwatch: self, elapsedTime: elapsedTime)
    }
    
    var isPaused: Bool {
        return paused
    }
    var isRunning: Bool {
        return timer?.isValid ?? false
    }
}
