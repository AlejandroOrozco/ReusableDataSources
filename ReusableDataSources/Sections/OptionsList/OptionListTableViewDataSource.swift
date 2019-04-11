//
//  OptionListTableViewDataSource.swift
//  ReusableDataSources
//
//  Created by Alejandro Orozco Builes on 3/11/19.
//  Copyright © 2019 Alejandro Orozco Builes. All rights reserved.
//

import UIKit

protocol OptionListTableViewDataSourceDelegate {
    func clickOption(option: String)
}

class OptionListTableViewDataSource: NSObject, TableViewDataSource {

    var delegate: OptionListTableViewDataSourceDelegate?
    var cellColor: UIColor

    var tickets: [String]
    
    init(models: [String], tableView: UITableView, cellColor: UIColor, delegate: OptionListTableViewDataSourceDelegate?) {
        self.tickets = models
        self.cellColor = cellColor
        self.delegate = delegate
        super.init()
        registerCells(tableView: tableView)
    }
    
    private func registerCells(tableView: UITableView){
        tableView.register(UINib(nibName: "OptionCell", bundle: .main), forCellReuseIdentifier: "OptionCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ticket = tickets[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell") as! OptionCell
        cell.ticket = (name: ticket, color: cellColor)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row != 3 else {
            tableView.scrollToRow(at: IndexPath(row: tickets.count - 1, section: indexPath.section), at: .top, animated: true)
            return
        }
        delegate?.clickOption(option: tickets[indexPath.row])
    }
}
