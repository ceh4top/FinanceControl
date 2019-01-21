//
//  HistoryController.swift
//  FinanceControl
//
//  Created by Viktoriia Tarasova on 16.01.2019.
//  Copyright © 2019 ITInsider. All rights reserved.
//

import UIKit

class HistoryController: UITableViewController {
    
    
    @IBAction func Back(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    var data: [CellData] = DataProcessing.getData()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HistoryCell = tableView.dequeueReusableCell(withIdentifier: "History", for: indexPath) as! HistoryCell

        let dataCell: CellData = data[indexPath.row]
        cell.nameLabel.text = "\(dataCell.name)"
        cell.costLabel.text = "\(dataCell.cost)"
        
        cell.dateLabel.text = DateHelper.formatter("dd.MM.yyyy HH:mm", dataCell.date)

        return cell
    }
}
