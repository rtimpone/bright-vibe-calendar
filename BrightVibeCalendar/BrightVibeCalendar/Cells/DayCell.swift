//
//  DayCell.swift
//  BrightVibeCalendar
//
//  Created by Rob Timpone on 5/4/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation
import UIKit

class DayCell: UICollectionViewCell, NibBased {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var circleViewsContainerView: UIView!
    @IBOutlet weak var outerCircleView: UIView!
    @IBOutlet weak var innerCircleView: UIView!
    @IBOutlet weak var monthStartView: UIView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var monthDayLabel: UILabel!
    
    func updateForDay(_ day: Int, selected isSelected: Bool, fontSize: CGFloat, theme: Theme) {
        
        let dayText = "\(day)"
        dayLabel.text = dayText
        monthDayLabel.text = dayText
        
        let shouldShowMonthLabel = day == 1
        dayLabel.isHidden = shouldShowMonthLabel
        monthStartView.isHidden = !shouldShowMonthLabel
        
        circleViewsContainerView.isHidden = !isSelected
        let textColor = isSelected ? theme.colors.dateTextSelected : theme.colors.dateTextUnselected
        dayLabel.textColor = textColor
        monthLabel.textColor = textColor
        monthDayLabel.textColor = textColor
        
        let newFont = UIFont(name: dayLabel.font.fontName, size: fontSize)
        dayLabel.font = newFont
        monthLabel.font = newFont
        monthDayLabel.font = newFont
        
        let circleColor = theme.colors.selectedDate
        outerCircleView.backgroundColor = circleColor.withAlphaComponent(0.4)
        innerCircleView.backgroundColor = circleColor
    }
}
