//
//  Date+.swift
//  meant
//
//  Created by 지연 on 9/25/24.
//

import Foundation

extension Date {
    func formatAsMonthYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
    func formatAsDayWeekday() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd (EEE)"
        return dateFormatter.string(from: self)
    }
}
