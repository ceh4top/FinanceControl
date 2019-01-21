//
//  Calculate.swift
//  FinanceControl
//
//  Created by Viktoriia Tarasova on 16.01.2019.
//  Copyright © 2019 ITInsider. All rights reserved.
//

import Foundation

enum SortedType {
    case asc
    case desc
    case none
}

class DataProcessing {
    private static let service: DataService = DataService.i()
    
    static func getData(_ type: SortedType = .desc) -> [CellData] {
        return type == .none
            ? service.getData()
            : service.getData().sorted(by: { (type == .asc) ? $0.date < $1.date : $0.date > $1.date });
    }
    static func getData(startDate: Date, endDate: Date, _ type: SortedType = .desc) -> [CellData] {
        return getData(type).filter({ startDate <= $0.date && $0.date <= endDate })
    }
    static func getData(countMonth: Int, endDate: Date, _ type: SortedType = .desc) -> [CellData] {
        let calendar = Calendar.current
        var component = DateComponents()
        component.month = -countMonth
        let startDate = calendar.date(byAdding: component, to: endDate) ?? endDate
        
        return (countMonth <= 0) ? getData(type) : getData(startDate: startDate, endDate: endDate, type)
    }
    
    private static func reduceCosts(_ data: [CellData]) -> Float {
        return data.reduce(0.0, { $0 + $1.cost })
    }
    
    static func getIncome() -> Float {
        return reduceCosts(getData(.none).filter({ $0.cost >= 0 }))
    }
    
    static func getIncome(startDate: Date, endDate: Date) -> Float {
        return reduceCosts(getData(startDate: startDate, endDate: endDate, .none).filter({ $0.cost >= 0 }))
    }
    
    static func getIncome(countMonth: Int, endDate: Date) -> Float {
        return reduceCosts(getData(countMonth: countMonth, endDate: endDate, .none).filter({ $0.cost >= 0 }))
    }
    
    static func getCosts() -> Float {
        return abs(reduceCosts(getData(.none).filter({ $0.cost < 0 })))
    }
    
    static func getCosts(startDate: Date, endDate: Date) -> Float {
        return abs(reduceCosts(getData(startDate: startDate, endDate: endDate, .none).filter({ $0.cost < 0 })))
    }
    
    static func getCosts(countMonth: Int, endDate: Date) -> Float {
        return abs(reduceCosts(getData(countMonth: countMonth, endDate: endDate, .none).filter({ $0.cost < 0 })))
    }
    
    static func getDifference() -> Float {
        return reduceCosts(getData(.none))
    }
    
    static func getDifference(startDate: Date, endDate: Date) -> Float {
        return reduceCosts(getData(startDate: startDate, endDate: endDate, .none))
    }
    
    static func getDifference(countMonth: Int, endDate: Date) -> Float {
        return reduceCosts(getData(countMonth: countMonth, endDate: endDate, .none))
    }
}
