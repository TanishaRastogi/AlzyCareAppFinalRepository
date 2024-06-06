//
//  MeditationSession.swift
//  Meditation
//
//  Created by Rishita kumari on 02/06/24.
//
import Foundation

class MeditationSession {
    var duration: TimeInterval
    var startTime: Date?
    var endTime: Date?
    var pausedTime: TimeInterval?

    init(duration: TimeInterval) {
        self.duration = duration
    }

    func start() {
        self.startTime = Date()
    }

    func end() {
        self.endTime = Date()
    }

    var elapsedTime: TimeInterval {
        if let pausedTime = pausedTime {
            return pausedTime
        } else if let start = startTime, let end = endTime {
            return end.timeIntervalSince(start)
        } else if let start = startTime {
            return Date().timeIntervalSince(start)
        } else {
            return 0
        }
    }

    var remainingTime: TimeInterval {
        return max(duration - elapsedTime, 0)
    }

    func pause() {
        pausedTime = elapsedTime
        startTime = nil
    }

    func resume() {
        if let pausedTime = pausedTime {
            startTime = Date().addingTimeInterval(-pausedTime)
            self.pausedTime = nil
        }
    }
}
