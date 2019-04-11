//
//  ViewController.swift
//  ReusableDataSources
//
//  Created by Alejandro Orozco Builes on 3/11/19.
//  Copyright © 2019 Alejandro Orozco Builes. All rights reserved.
//

import UIKit

typealias TableViewDataSource = UITableViewDataSource & UITableViewDelegate

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    private var tableViewDataSources: [TableViewDataSource] = []
    
    var displaySecondOption = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSources()
    }
    
    private func configureDataSources(){
        // Offers Selector
        let offers = [(name: "First Option", selected: true),(name: "Second Option", selected: false) ]
        let offerSelector = OptionsSelectorTableViewDataSource(offers: offers, tableView: tableView, delegate: self)
        
        // Ticket Sales
        let tickets = (1...30).map({String($0)})
        let ticketSales = OptionListTableViewDataSource(models: tickets,
                                                tableView: tableView,
                                                cellColor: .blue,
                                                delegate: self)
        // Ticket Listing
        let ticketsR = (1...20).map({String($0)})
        let ticketListing = OptionListTableViewDataSource(models: ticketsR,
                                                tableView: tableView,
                                                cellColor: .orange,
                                                delegate: self)
        
        tableViewDataSources = [offerSelector, ticketSales, ticketListing]
        tableView.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewDataSources.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dataSource = tableViewDataSources[section]
        switch section {
            case 1: guard displaySecondOption else { return 0 }
            case 2: guard !displaySecondOption else { return 0 }
            default: break
        }
        return dataSource.tableView(tableView,numberOfRowsInSection: 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataSource = tableViewDataSources[indexPath.section]
        return dataSource.tableView(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataSource = tableViewDataSources[indexPath.section]
        if dataSource.responds(to: #selector(UITableViewDelegate.tableView(_:didSelectRowAt:))) {
            dataSource.tableView!(tableView, didSelectRowAt: indexPath)
        }
    }

}

extension ViewController: OptionListTableViewDataSourceDelegate {
    func clickOption(option: String) {
        print(option)
    }
}

extension ViewController: OptionSelectorTableViewDataSourceDelegate {
    func didOptionChanged(option: (name: String, selected: Bool)) {
        displaySecondOption = option.name == "Second Option"
        tableView.reloadData()
    }
}
