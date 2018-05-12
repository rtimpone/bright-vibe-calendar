//
//  HeaderView.swift
//  BrightVibeCalendar
//
//  Created by Rob Timpone on 5/12/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView, NibBased {
    
    @IBOutlet weak var day1Label: UILabel!
    @IBOutlet weak var day2Label: UILabel!
    @IBOutlet weak var day3Label: UILabel!
    @IBOutlet weak var day4Label: UILabel!
    @IBOutlet weak var day5Label: UILabel!
    @IBOutlet weak var day6Label: UILabel!
    @IBOutlet weak var day7Label: UILabel!
    
    func updateLabels(forDays days: [String]) {
        for (index, textForDay) in days.enumerated() {
            if let dayLabel = label(forIndex: index) {
                dayLabel.text = textForDay
            }
        }
    }
}

private extension HeaderView {
    
    func label(forIndex index: Int) -> UILabel? {
        
        let dayNumber = index + 1
        
        switch dayNumber {
        case 1:
            return day1Label
        case 2:
            return day2Label
        case 3:
            return day3Label
        case 4:
            return day4Label
        case 5:
            return day5Label
        case 6:
            return day6Label
        case 7:
            return day7Label
        default:
            return nil
        }
    }
}
