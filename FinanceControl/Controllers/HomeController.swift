//
//  HomeController.swift
//  FinanceControl
//
//  Created by Viktoriia Tarasova on 16.01.2019.
//  Copyright © 2019 ITInsider. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    @IBAction func Back(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBOutlet weak var dateMonth: UILabel!
    @IBOutlet weak var costIncome: UILabel!
    @IBOutlet weak var costConsumption: UILabel!
    @IBOutlet weak var balance: UILabel!
    
    private func initData() {
        
        costIncome.text = "\(DataProcessing.getIncome(countMonth: 1, endDate: Date())) ₽"
        costConsumption.text = "\(DataProcessing.getCosts(countMonth: 1, endDate: Date())) ₽"
        balance.text = "\(DataProcessing.getDifference(countMonth: 1, endDate: Date())) ₽"
        
        dateMonth.text =  DateHelper.formatter("dd") + " " + DateHelper.formatter("MMMM").uppercased()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        initData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initData()
    }
}
