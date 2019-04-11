//
//  OptionsSelectorCell.swift
//  ReusableDataSources
//
//  Created by Alejandro Orozco Builes on 3/11/19.
//  Copyright © 2019 Alejandro Orozco Builes. All rights reserved.
//

import UIKit

class OptionsSelectorCell: UITableViewCell {
    @IBOutlet weak var offerName: UILabel!
    @IBOutlet weak var selectOfferSwitch: UISwitch!
    
    var delegate: OptionSelectorTableViewDataSourceDelegate?
    
    var offer: (name: String, selected: Bool)? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        offerName.text = offer?.name
        selectOfferSwitch.isOn = offer?.selected ?? false
    }
    

    @IBAction func didChange(_ sender: Any) {
        guard let offer = offer, delegate != nil else { return }
        delegate?.didOptionChanged(option: offer)
    }
    
}
