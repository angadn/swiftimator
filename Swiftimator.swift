//
//  Swiftimator.swift
//  tincan-sdk
//
//  Created by Angad Nadkarni on 21/09/16.
//  Copyright © 2016 Hullo Technologies Pvt. Ltd. All rights reserved.
//

import Foundation

class Swiftimator {
    let transform: Double -> Void
    let startValue: Double
    let endValue: Double
    let duration: Double

    var onFinish: Void -> Void = { }

    private var incrementalValue: Double
    private var timer: NSTimer?
    private var currentValue: Double

    init(
        startValue: Double,
        endValue: Double,
        duration: Double,
        transform: Double -> Void
    ) {
        self.startValue = startValue
        self.currentValue = startValue
        self.endValue = endValue
        self.duration = duration
        self.incrementalValue = (self.endValue - self.startValue)/self.duration/100
        self.transform = transform
    }

    func start() {
        self.currentValue = self.startValue
        self.timer = NSTimer.scheduledTimerWithTimeInterval(
            0.01 as NSTimeInterval,
            target: self,
            selector: #selector(Swiftimator.repeatTransform),
            userInfo: nil,
            repeats: true
        )
    }

    func stop() {
        if let timer = self.timer {
            timer.invalidate()
            self.onFinish()
        }
    }

    @objc func repeatTransform() {
        let v = self.currentValue + self.incrementalValue
        if self.endValue >= self.startValue ? v <= self.endValue : v >= self.endValue {
            self.transform(v)
            self.currentValue = v
        } else {
            self.stop()
        }
    }
}
