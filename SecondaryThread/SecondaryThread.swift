//
//  SecondaryThread.swift
//  SecondaryThread
//
//  Created by Vasiliy Fedotov on 09/04/2019.
//  Copyright © 2019 Vasiliy Fedotov. All rights reserved.
//

import Foundation

class SecondaryThread: Thread {
    
    override init() {
        super.init()
        
        qualityOfService = .utility
    }
    
    override func main() {
        // calc pi
        
        
        
        autoreleasepool {
            
            print("begin pi calculation, thread \(Thread.current)")
            
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
            
            print("calculated, pi = \(pi), thread \(Thread.current)")
            print("time = \(Int(dateEnd.timeIntervalSince(dateBegin)))")
        }
    }
    
    
    
}
