//
//  DataService.swift
//  FuelControl
//
//  Created by Viktoriia Tarasova on 15.01.2019.
//  Copyright © 2019 ITInsider. All rights reserved.
//

import Foundation

class DataService {
    
    private static var instance: DataService? = nil
    public static func i() -> DataService {
        if instance == nil {
            instance = DataService()
        }
        return instance!
    }
    
    private var data: [CellData]
    
    private init() {
        self.data = []
        
        let standart = UserDefaults.standard
        let count = standart.integer(forKey: "count")
        if count > 0 {
            for i in 0...(count - 1) {
                let refueling = CellData(
                    name: standart.string(forKey: "name\(i)") ?? "Запись №\(i + 1)",
                    cost: standart.float(forKey: "cost\(i)"),
                    date: standart.object(forKey: "date\(i)") as? Date ?? Date()
                )
                self.data.append(refueling)
            }
        } else {
            for i in 0...20 {
                let calendar = Calendar.current
                var component = DateComponents()
                component.month = -i
                let currentDate = Date()
                
                let cell = CellData(
                    name: "Запись №\(21 - i)",
                    cost: Float(100 * (i + 1) * ((i % 2 == 0) ? 1 : -1)),
                    date: calendar.date(byAdding: component, to: currentDate) ?? currentDate
                )
                
                data.append(cell)
            }
        }
    }
    
    func getData() -> [CellData] {
        return data
    }
    
    func setData(_ data: [CellData]) {
        for v in data {
            setData(v)
        }
    }
    
    func setData(_ data: CellData) {
        self.data.append(data)
    }
    
    func saveData() {
        let count = self.data.count
        UserDefaults.standard.set(count, forKey: "count")
        
        var i = 0
        for v in self.data {
            UserDefaults.standard.set(v.name, forKey: "name\(i)")
            UserDefaults.standard.set(v.cost, forKey: "cost\(i)")
            UserDefaults.standard.set(v.date, forKey: "date\(i)")
            i += 1
        }
        UserDefaults.standard.synchronize()
    }
    
    func clear() {
        let count = UserDefaults.standard.integer(forKey: "count")
        
        UserDefaults.standard.removeObject(forKey: "count")
        
        if (count > 0) {
            for i in 0...(count - 1) {
                UserDefaults.standard.removeObject(forKey: "name\(i)")
                UserDefaults.standard.removeObject(forKey: "cost\(i)")
                UserDefaults.standard.removeObject(forKey: "date\(i)")
            }
        }
        
        UserDefaults.standard.synchronize()
        self.data = []
    }
}
