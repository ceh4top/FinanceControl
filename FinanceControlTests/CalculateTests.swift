//
//  CalculateTests.swift
//  FinanceControlTests
//
//  Created by Viktoriia Tarasova on 16.01.2019.
//  Copyright © 2019 ITInsider. All rights reserved.
//

import XCTest
@testable import FinanceControl

class CalculateTests: XCTestCase {
    
    func testGetData() {
        var data: [CellData] = []
        
        for i in 0...20 {
            let calendar = Calendar.current
            var component = DateComponents()
            component.month = -i
            let currentDate = Date()
            
            let cell = CellData(
                name: "Запись №\(i + 1)",
                cost: Float(100 * (i + 1) * ((i % 2 == 0) ? 1 : -1)),
                date: calendar.date(byAdding: component, to: currentDate) ?? currentDate
            )
            
            data.append(cell)
        }
        
        DataService.i().clear()
        DataService.i().setData(data)
        
        let processingData: [CellData] = DataProcessing.getData(.none)
        let testData: [CellData] = data
        
        var i = 0
        for v in processingData {
            XCTAssertEqual(v.name, testData[i].name)
            XCTAssertEqual(v.cost, testData[i].cost)
            XCTAssertEqual(v.date, testData[i].date)
            i += 1
        }
    }

    func testGetDataSorted() {
        var data: [CellData] = []
        
        for i in 0...20 {
            let calendar = Calendar.current
            var component = DateComponents()
            component.month = -i
            let currentDate = Date()
            
            let cell = CellData(
                name: "Запись №\(i + 1)",
                cost: Float(100 * (i + 1) * ((i % 2 == 0) ? 1 : -1)),
                date: calendar.date(byAdding: component, to: currentDate) ?? currentDate
            )
            
            data.append(cell)
        }
        
        DataService.i().clear()
        DataService.i().setData(data)
        
        let processingData: [CellData] = DataProcessing.getData()
        let testData: [CellData] = data.sorted(by: { $0.date > $1.date })
        
        var i = 0
        for v in processingData {
            XCTAssertEqual(v.name, testData[i].name)
            XCTAssertEqual(v.cost, testData[i].cost)
            XCTAssertEqual(v.date, testData[i].date)
            i += 1
        }
    }
    
    func testGetDataFilter1() {
        var data: [CellData] = []
        
        let calendar = Calendar.current
        var component = DateComponents()
        
        for i in 0...20 {
            component.month = -i
            let currentDate = Date()
            
            let cell = CellData(
                name: "Запись №\(i + 1)",
                cost: Float(100 * (i + 1) * ((i % 2 == 0) ? 1 : -1)),
                date: calendar.date(byAdding: component, to: currentDate) ?? currentDate
            )
            
            data.append(cell)
        }
        
        component.month = -1
        component.year = 0
        
        let endDate: Date = Date()
        let startDate: Date = calendar.date(byAdding: component, to: endDate) ?? endDate
        
        DataService.i().clear()
        DataService.i().setData(data)
        
        let processingData: [CellData] = DataProcessing.getData(startDate: startDate, endDate: endDate)
        let testData: [CellData] = data
            .filter({ startDate <= $0.date && $0.date <= endDate})
        .sorted(by: { $0.date > $1.date })
        
        var i = 0
        for v in processingData {
            XCTAssertEqual(v.name, testData[i].name)
            XCTAssertEqual(v.cost, testData[i].cost)
            XCTAssertEqual(v.date, testData[i].date)
            i += 1
        }
    }
    
    func testGetDataFilter2() {
        var data: [CellData] = []
        
        let calendar = Calendar.current
        var component = DateComponents()
        
        for i in 0...20 {
            component.month = -i
            let currentDate = Date()
            
            let cell = CellData(
                name: "Запись №\(i + 1)",
                cost: Float(100 * (i + 1) * ((i % 2 == 0) ? 1 : -1)),
                date: calendar.date(byAdding: component, to: currentDate) ?? currentDate
            )
            
            data.append(cell)
        }
        
        component.month = -3
        component.year = 0
        
        let endDate: Date = Date()
        let startDate: Date = calendar.date(byAdding: component, to: endDate) ?? endDate
        
        DataService.i().clear()
        DataService.i().setData(data)
        
        let processingData: [CellData] = DataProcessing.getData(countMonth: 3, endDate: endDate)
        let testData: [CellData] = data
            .filter({ startDate <= $0.date && $0.date <= endDate})
            .sorted(by: { $0.date > $1.date })
        
        var i = 0
        for v in processingData {
            XCTAssertEqual(v.name, testData[i].name)
            XCTAssertEqual(v.cost, testData[i].cost)
            XCTAssertEqual(v.date, testData[i].date)
            i += 1
        }
    }

    func testGetIncome() {
        var data: [CellData] = []
        
        let calendar = Calendar.current
        var component = DateComponents()
        
        for i in 0...60 {
            component.day = -i
            let currentDate = Date()
            
            let cell = CellData(
                name: "Запись №\(i + 1)",
                cost: Float(100 * (i + 1) * ((i % 2 == 0) ? 1 : -1)),
                date: calendar.date(byAdding: component, to: currentDate) ?? currentDate
            )
            
            data.append(cell)
        }
        
        DataService.i().clear()
        DataService.i().setData(data)
        
        let processingResult: Float = DataProcessing.getIncome()
        let testResult: Float = data.filter({ $0.cost >= 0 }).reduce(0.0, { $0 + $1.cost })
        
        XCTAssertEqual(processingResult, testResult)
    }
    
    func testGetIncomeFilter1() {
        var data: [CellData] = []
        
        let calendar = Calendar.current
        var component = DateComponents()
        
        for i in 0...60 {
            component.day = -i
            let currentDate = Date()
            
            let cell = CellData(
                name: "Запись №\(i + 1)",
                cost: Float(100 * (i + 1) * ((i % 2 == 0) ? 1 : -1)),
                date: calendar.date(byAdding: component, to: currentDate) ?? currentDate
            )
            
            data.append(cell)
        }
        
        component.month = -1
        let endDate: Date = Date()
        let startDate: Date = calendar.date(byAdding: component, to: endDate) ?? endDate
        
        DataService.i().clear()
        DataService.i().setData(data)
        
        let processingResult: Float = DataProcessing.getIncome(startDate: startDate, endDate: endDate)
        let testResult: Float = data
            .filter({ startDate <= $0.date && $0.date <= endDate && $0.cost >= 0 })
            .reduce(0.0, { $0 + $1.cost })
        
        XCTAssertEqual(processingResult, testResult)
    }
    
    func testGetIncomeFilter2() {
        var data: [CellData] = []
        
        let calendar = Calendar.current
        var component = DateComponents()
        
        for i in 0...60 {
            component.day = -i
            let currentDate = Date()
            
            let cell = CellData(
                name: "Запись №\(i + 1)",
                cost: Float(100 * (i + 1) * ((i % 2 == 0) ? 1 : -1)),
                date: calendar.date(byAdding: component, to: currentDate) ?? currentDate
            )
            
            data.append(cell)
        }
        
        component.month = -1
        component.day = 0
        
        let endDate: Date = Date()
        let startDate: Date = calendar.date(byAdding: component, to: endDate) ?? endDate
        
        DataService.i().clear()
        DataService.i().setData(data)
        
        let processingResult: Float = DataProcessing.getIncome(countMonth: 1, endDate: endDate)
        let testResult: Float = data
            .filter({ startDate <= $0.date && $0.date <= endDate && $0.cost >= 0 })
            .reduce(0.0, { $0 + $1.cost })
        
        XCTAssertEqual(processingResult, testResult)
    }
    
    func testGetCosts() {
        var data: [CellData] = []
        
        let calendar = Calendar.current
        var component = DateComponents()
        
        for i in 0...60 {
            component.day = -i
            let currentDate = Date()
            
            let cell = CellData(
                name: "Запись №\(i + 1)",
                cost: Float(100 * (i + 1) * ((i % 2 == 0) ? 1 : -1)),
                date: calendar.date(byAdding: component, to: currentDate) ?? currentDate
            )
            
            data.append(cell)
        }
        
        DataService.i().clear()
        DataService.i().setData(data)
        
        let processingResult: Float = DataProcessing.getCosts()
        let testResult: Float = abs(data.filter({ $0.cost < 0 }).reduce(0.0, { $0 + $1.cost }))
        
        XCTAssertEqual(processingResult, testResult)
    }
    
    func testGetCostsFilter1() {
        var data: [CellData] = []
        
        let calendar = Calendar.current
        var component = DateComponents()
        
        for i in 0...60 {
            component.day = -i
            let currentDate = Date()
            
            let cell = CellData(
                name: "Запись №\(i + 1)",
                cost: Float(100 * (i + 1) * ((i % 2 == 0) ? 1 : -1)),
                date: calendar.date(byAdding: component, to: currentDate) ?? currentDate
            )
            
            data.append(cell)
        }
        
        component.month = -1
        let endDate: Date = Date()
        let startDate: Date = calendar.date(byAdding: component, to: endDate) ?? endDate
        
        DataService.i().clear()
        DataService.i().setData(data)
        
        let processingResult: Float = DataProcessing.getCosts(startDate: startDate, endDate: endDate)
        let testResult: Float = abs(data
            .filter({ startDate <= $0.date && $0.date <= endDate && $0.cost < 0 })
            .reduce(0.0, { $0 + $1.cost }))
        
        XCTAssertEqual(processingResult, testResult)
    }
    
    func testGetCostsFilter2() {
        var data: [CellData] = []
        
        let calendar = Calendar.current
        var component = DateComponents()
        
        for i in 0...60 {
            component.day = -i
            let currentDate = Date()
            
            let cell = CellData(
                name: "Запись №\(i + 1)",
                cost: Float(100 * (i + 1) * ((i % 2 == 0) ? 1 : -1)),
                date: calendar.date(byAdding: component, to: currentDate) ?? currentDate
            )
            
            data.append(cell)
        }
        
        component.month = -1
        component.day = 0
        
        let endDate: Date = Date()
        let startDate: Date = calendar.date(byAdding: component, to: endDate) ?? endDate
        
        DataService.i().clear()
        DataService.i().setData(data)
        
        let processingResult: Float = DataProcessing.getCosts(countMonth: 1, endDate: endDate)
        let testResult: Float = abs(data
            .filter({ startDate <= $0.date && $0.date <= endDate && $0.cost < 0 })
            .reduce(0.0, { $0 + $1.cost }))
        
        XCTAssertEqual(processingResult, testResult)
    }
    
    func testGetDifference() {
        var data: [CellData] = []
        
        let calendar = Calendar.current
        var component = DateComponents()
        
        for i in 0...60 {
            component.day = -i
            let currentDate = Date()
            
            let cell = CellData(
                name: "Запись №\(i + 1)",
                cost: Float(100 * (i + 1) * ((i % 2 == 0) ? 1 : -1)),
                date: calendar.date(byAdding: component, to: currentDate) ?? currentDate
            )
            
            data.append(cell)
        }
        
        DataService.i().clear()
        DataService.i().setData(data)
        
        let processingResult: Float = DataProcessing.getDifference()
        let testResult: Float = data.reduce(0.0, { $0 + $1.cost })
        
        XCTAssertEqual(processingResult, testResult)
    }
    
    func testGetDifferenceFilter1() {
        var data: [CellData] = []
        
        let calendar = Calendar.current
        var component = DateComponents()
        
        for i in 0...60 {
            component.day = -i
            let currentDate = Date()
            
            let cell = CellData(
                name: "Запись №\(i + 1)",
                cost: Float(100 * (i + 1) * ((i % 2 == 0) ? 1 : -1)),
                date: calendar.date(byAdding: component, to: currentDate) ?? currentDate
            )
            
            data.append(cell)
        }
        
        component.month = -1
        let endDate: Date = Date()
        let startDate: Date = calendar.date(byAdding: component, to: endDate) ?? endDate
        
        DataService.i().clear()
        DataService.i().setData(data)
        
        let processingResult: Float = DataProcessing.getDifference(startDate: startDate, endDate: endDate)
        let testResult: Float = data
            .filter({ startDate <= $0.date && $0.date <= endDate})
            .reduce(0.0, { $0 + $1.cost })
        
        XCTAssertEqual(processingResult, testResult)
    }
    
    func testGetDifferenceFilter2() {
        var data: [CellData] = []
        
        let calendar = Calendar.current
        var component = DateComponents()
        
        for i in 0...60 {
            component.day = -i
            let currentDate = Date()
            
            let cell = CellData(
                name: "Запись №\(i + 1)",
                cost: Float(100 * (i + 1) * ((i % 2 == 0) ? 1 : -1)),
                date: calendar.date(byAdding: component, to: currentDate) ?? currentDate
            )
            
            data.append(cell)
        }
        
        component.month = -1
        component.day = 0
        let endDate: Date = Date()
        let startDate: Date = calendar.date(byAdding: component, to: endDate) ?? endDate
        
        DataService.i().clear()
        DataService.i().setData(data)
        
        let processingResult: Float = DataProcessing.getDifference(countMonth: 1, endDate: endDate)
        let testResult: Float = data
            .filter({ startDate <= $0.date && $0.date <= endDate })
            .reduce(0.0, { $0 + $1.cost })
        
        XCTAssertEqual(processingResult, testResult)
    }
    
    
}
