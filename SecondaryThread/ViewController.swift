//
//  ViewController.swift
//  SecondaryThread
//
//  Created by Vasiliy Fedotov on 09/04/2019.
//  Copyright © 2019 Vasiliy Fedotov. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    private var thread: SecondaryThread?
    
    @IBOutlet weak var tableView: UITableView!
    
    var strings: [String] = [] {
        didSet {
            updateView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        beginSecondaryThread()
    }
    
    private func setupViews() {
        tableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        
        tableView.dataSource = self
    }
    
    private func updateView() {
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .top)
        tableView.endUpdates()
    }
    

    
}

extension ViewController {
    private func beginSecondaryThread() {
        thread = SecondaryThread()
        thread?.start()
    }
    
    @IBAction func fireButtonTapped(_ sender: Any) {
        
        SecondaryThread.source.fireSource()
    }
    
    @IBAction func invalidateButtonTapped(_ sender: Any) {
        thread?.cancel()
        
        SecondaryThread.source.invalidate()
        
        thread = nil
    }
}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        let text = strings[indexPath.row]
        cell.setText(text)
        
        return cell
    }
    
}

