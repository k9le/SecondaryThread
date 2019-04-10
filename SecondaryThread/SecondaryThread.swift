//
//  SecondaryThread.swift
//  SecondaryThread
//
//  Created by Vasiliy Fedotov on 09/04/2019.
//  Copyright © 2019 Vasiliy Fedotov. All rights reserved.
//

import Foundation

final class SecondaryThread: Thread {
    
    private static var number: Int = 0
    private let threadNamePrefix: String = "SecondaryCustom"
    
    static let runLoopModeString: String = "SecondaryThreadLoopMode"
    
    public static let source: ThreadSource = ThreadSource()

    
    override init() {
        super.init()
        
        qualityOfService = .utility
        
        
    }
    
    override func main() {

        autoreleasepool {

            SecondaryThread.number += 1
            Thread.current.name = "\(threadNamePrefix) \(SecondaryThread.number)"

            viewOutput("start secondary thread")

            SecondaryThread.source.addToCurrentRunLoop()

            repeat {
                viewOutput("runloop repeat")
                RunLoop.current.run(mode: RunLoop.Mode(SecondaryThread.runLoopModeString), before: Date.distantFuture)
            } while(!isCancelled && !isFinished)

            viewOutput("finish secondary thread")
        }

    }
    
}
