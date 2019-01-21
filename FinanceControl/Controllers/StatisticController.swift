//
//  StatisticController.swift
//  FinanceControl
//
//  Created by Viktoriia Tarasova on 16.01.2019.
//  Copyright © 2019 ITInsider. All rights reserved.
//

import UIKit

class StatisticController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var cost2Label: UILabel!
    @IBOutlet weak var cost3Label: UILabel!
    
    @IBAction func Back(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBOutlet weak var date: UITextField!
    var dateValue: Date = Date()
    let dateMonth: [(name: String, count: Int)] = [
        (name: "за месяц", count: 1),
        (name: "за 3 месяца", count: 3),
        (name: "за 6 месяцев", count: 6),
        (name: "за год", count: 12),
        (name: "за все время", count: 0),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mountPicker = UIPickerView()
        mountPicker.delegate = self
        mountPicker.tag = 1
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Применить", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        date.inputView = mountPicker
        date.inputAccessoryView = toolBar
        
        date.text = dateMonth[0].name
        mountPicker.selectRow(0, inComponent: 0, animated: false)
        update(month: mountPicker.selectedRow(inComponent: 0))
    }
    
    @objc func donePicker (sender:UIBarButtonItem)
    {
        if (sender.title == "Применить" && (date.text == nil || date.text == "")) {
            date.text = dateMonth[0].name
        }
        date.endEditing(true)
        
        if let datePiker = date.inputView as? UIPickerView {
            update(month: datePiker.selectedRow(inComponent: 0))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 1 {
            return dateMonth.count
        }
        
        return 0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1 {
            return dateMonth[row].name
        }
        
        return nil
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1 {
            date.text = dateMonth[row].name
            update(month: row)
        }
        
    }
    
    func update(month: Int) {
        costLabel.text = "\(DataProcessing.getIncome(countMonth: dateMonth[month].count, endDate: Date())) ₽"
        cost2Label.text = "\(DataProcessing.getCosts(countMonth: dateMonth[month].count, endDate: Date())) ₽"
        cost3Label.text = "\(DataProcessing.getDifference(countMonth: dateMonth[month].count, endDate: Date())) ₽"
    }

}
