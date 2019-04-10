//
//  OutputFunc.swift
//  SecondaryThread
//
//  Created by Vasiliy Fedotov on 10/04/2019.
//  Copyright © 2019 Vasiliy Fedotov. All rights reserved.
//

import Foundation
import UIKit

internal func viewOutput(_ string: String) {
    
    let threadSuffix: String = "\nthread: \(Thread.current.name ?? "noname")"
    
    DispatchQueue.main.async {
        guard let vc = (UIApplication.shared.delegate as? AppDelegate)?.viewController else { return }
        
        vc.strings = [string + threadSuffix] + vc.strings
    }
    
}
