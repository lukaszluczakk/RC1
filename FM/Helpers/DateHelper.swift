//
//  DateHelper.swift
//  FM
//
//  Created by Łukasz Łuczak on 06/09/2021.
//

import Foundation

class DateHelper {
    static func from(year: Int, month: Int, day: Int) -> Date {
        let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let date = gregorianCalendar.date(from: dateComponents)!
        return date
    }
}
