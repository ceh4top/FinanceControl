//
//  DateHelper.swift
//  FinanceControl
//
//  Created by Viktoriia Tarasova on 17.01.2019.
//  Copyright © 2019 ITInsider. All rights reserved.
//

import Foundation

class DateHelper {
    private static let dateFormatter = DateFormatter()
    
    static func formatter(_ format: String, _ date: Date = Date()) -> String {
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}
