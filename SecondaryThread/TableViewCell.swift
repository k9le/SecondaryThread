//
//  TableViewCell.swift
//  SecondaryThread
//
//  Created by Vasiliy Fedotov on 10/04/2019.
//  Copyright © 2019 Vasiliy Fedotov. All rights reserved.
//

import UIKit

final class TableViewCell: UITableViewCell {

    @IBOutlet private weak var view: UIView!
    @IBOutlet private weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        view.transform = CGAffineTransform(scaleX: 1, y: -1)
        label.font = UIFont(name: "Multicolore", size: 17)
    }
    
    
    func setText(_ text: String) {
        label.text = text
    }

}
