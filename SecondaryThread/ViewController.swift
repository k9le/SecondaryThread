//
//  ViewController.swift
//  SecondaryThread
//
//  Created by Vasiliy Fedotov on 09/04/2019.
//  Copyright © 2019 Vasiliy Fedotov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("commit pi calc, thread \(Thread.current)")
        let thread = SecondaryThread()
        thread.start()
    }


}

