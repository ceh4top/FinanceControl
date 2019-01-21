//
//  AddController.swift
//  FinanceControl
//
//  Created by Viktoriia Tarasova on 16.01.2019.
//  Copyright © 2019 ITInsider. All rights reserved.
//

import UIKit

class AddController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var costTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        let cell = CellData(
            name: nameTextField.text!,
            cost: (Float(costTextField.text!) ?? 0) * ((type) ? 1 : -1),
            date: Date()
        )
        service.setData(cell)
        service.saveData()
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func changedTextField(_ sender: Any) {
        if ((nameTextField.text == nil || nameTextField.text == "") ||
            (costTextField.text == nil) || (costTextField.text == "")) {
            return
        }
        
        saveButton.isEnabled = true
    }
    
    var type: Bool = true
    let service: DataService = DataService.i()
    var data: [CellData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        type = self.title == "Доход"
        
        data = service.getData()
        
        nameTextField.text = "Запись №\(data.count + 1)"
    }

}
