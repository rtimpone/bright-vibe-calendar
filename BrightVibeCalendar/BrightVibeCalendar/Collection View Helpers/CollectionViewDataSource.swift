//
//  CollectionViewDataSource.swift
//  BrightVibeCalendar
//
//  Created by Rob Timpone on 5/24/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation

enum CalendarItem {
    case blank
    case date(Date)
}

struct CollectionViewDataSource {
    
    var selectedDate: Date
    var items: [CalendarItem] = []
    
    init(monthsBeforeAndAfterToday months: Int) {
        
        let calendar = Calendar.current
        let now = Date()
        selectedDate = now
        
        let daysToCreate = 12 * months + 3
        
        for i in -(daysToCreate)...daysToCreate {
            if let date = calendar.date(byAdding: .day, value: i, to: now) {
                let item = CalendarItem.date(date)
                items.append(item)
            }
        }
        
        guard let firstItem = items.first else {
            return
        }
        
        guard case .date(let firstDate) = firstItem else {
            return
        }
        
        let numberOfBlankDaysToAdd = calendar.numberOfWeekdaysBefore(date: firstDate)
        if numberOfBlankDaysToAdd > 0 {
            for _ in 1...numberOfBlankDaysToAdd {
                items.insert(CalendarItem.blank, at: 0)
            }
        }
    }
    
    func itemIsSelected(_ item: CalendarItem) -> Bool {
        switch item {
        case .blank:
            return false
        case .date (let date):
            return date == selectedDate
        }
    }
}

extension Calendar {
    
    func numberOfWeekdaysBefore(date: Date) -> Int {
        
        let maxNumberOfWeekdays = 7
        var numberOfWeekdaysBeforeDate = 0
        
        var tempDate = date
        
        while numberOfWeekdaysBeforeDate < maxNumberOfWeekdays {
            
            if dateIsOnTheFirstWeekdayOfTheWeek(tempDate) {
                break
            }
            
            tempDate = dayBefore(date: tempDate)
            numberOfWeekdaysBeforeDate += 1
        }
        
        return numberOfWeekdaysBeforeDate
    }
    
    private func dateIsOnTheFirstWeekdayOfTheWeek(_ date: Date) -> Bool {
        let weekdayForDate = component(.weekday, from: date)
        return weekdayForDate == firstWeekday
    }
    
    private func dayBefore(date: Date) -> Date {
        guard let dayBeforeDate = self.date(byAdding: .day, value: -1, to: date) else {
            fatalError("Could not create date one day before '\(date)'")
        }
        return dayBeforeDate
    }
}
