//
//  OptionCell.swift
//  ReusableDataSources
//
//  Created by Alejandro Orozco Builes on 3/11/19.
//  Copyright © 2019 Alejandro Orozco Builes. All rights reserved.
//

import UIKit

class OptionCell: UITableViewCell {
    
    @IBOutlet weak var ticketName: UILabel!
    
    var ticket: (name: String, color: UIColor)? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI(){
        ticketName.text = ticket?.name
        contentView.backgroundColor = ticket?.color
    }
}
