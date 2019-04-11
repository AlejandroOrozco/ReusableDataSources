//
//  OptionsSelectorTableViewDataSource.swift
//  ReusableDataSources
//
//  Created by Alejandro Orozco Builes on 3/11/19.
//  Copyright © 2019 Alejandro Orozco Builes. All rights reserved.
//

import UIKit

protocol OptionSelectorTableViewDataSourceDelegate {
    func didOptionChanged(option: (name: String, selected: Bool))
}

class OptionsSelectorTableViewDataSource: NSObject, TableViewDataSource {
    
    var offers: [(name: String, selected: Bool)]
    var delegate: OptionSelectorTableViewDataSourceDelegate?
    
    init(offers: [(name: String, selected: Bool)], tableView: UITableView, delegate: OptionSelectorTableViewDataSourceDelegate) {
        self.offers = offers
        self.delegate = delegate
        super.init()
        registerCells(tableView: tableView)
    }
    
    private func registerCells(tableView: UITableView){
        tableView.register(UINib(nibName: "OptionsSelectorCell", bundle: .main), forCellReuseIdentifier: "OptionsSelectorCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionsSelectorCell") as! OptionsSelectorCell
        cell.offer = offers[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension OptionsSelectorTableViewDataSource: OptionSelectorTableViewDataSourceDelegate {
    func didOptionChanged(option: (name: String, selected: Bool)) {
        selectOffer(name: option.name)
        delegate?.didOptionChanged(option: option)
    }
    
    private func selectOffer(name: String) {
        offers = offers.map({(name: $0.name, selected: $0.name == name)})
    }
}
