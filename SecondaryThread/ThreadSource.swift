//
//  ThreadSource.swift
//  SecondaryThread
//
//  Created by Vasiliy Fedotov on 10/04/2019.
//  Copyright © 2019 Vasiliy Fedotov. All rights reserved.
//

import Foundation


fileprivate func runLoopSourcePerformRoutine(_ info: UnsafeMutableRawPointer!) {

    viewOutput("begin pi calculation")
    
    let dateBegin = Date()
    
    srand48(Int(arc4random()))
    
    func rand(from: Double, to: Double) -> Double {
        assert(to - from > 0)
        let seed = drand48()
        return seed * (to - from) + from
    }
    
    /// The size of the rectangle
    let a = 10.0
    
    /// The radius of the inner circle
    let r = a / 2
    
    ///
    let loopCount = 100000000
    
    var circleCount = 0
    
    let rangeLower = -5.0
    let rangeUpper = 5.0
    
    for _ in 0..<loopCount {
        let x = rand(from: rangeLower, to: rangeUpper)
        let y = rand(from: rangeLower, to: rangeUpper)
        
        if x * x + y * y <= r * r {
            circleCount += 1
        }
    }
    
    let rate = Double(circleCount) / Double(loopCount)
    let pi = (rate * a * a) / (r * r)
    
    
    let dateEnd = Date()
    
    viewOutput("pi calculated, value = \(pi), \ntime = \(Int(dateEnd.timeIntervalSince(dateBegin))) sec")
}
    
final class ThreadSource {
    
    private let runLoopSource: CFRunLoopSource
    
    private var runLoop: CFRunLoop?
    
    init() {
        var context = CFRunLoopSourceContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil, equal: nil, hash: nil, schedule: nil, cancel: nil, perform: runLoopSourcePerformRoutine)
        
        runLoopSource = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context)
    }
    
    public func addToCurrentRunLoop() {
        let rl = CFRunLoopGetCurrent()
        
        runLoop = rl
        CFRunLoopAddSource(rl, runLoopSource, CFRunLoopMode(SecondaryThread.runLoopModeString as CFString))
    }
    
    public func fireSource() {
        guard let runLoop = runLoop else { return }
        
        CFRunLoopSourceSignal(runLoopSource)
        CFRunLoopWakeUp(runLoop)
    }
    
    public func invalidate() {
        CFRunLoopSourceInvalidate(runLoopSource)
        
        if let runLoop = runLoop, CFRunLoopIsWaiting(runLoop) {
            CFRunLoopWakeUp(runLoop)
        }
    }
    
}
