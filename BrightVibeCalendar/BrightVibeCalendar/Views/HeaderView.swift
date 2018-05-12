//
//  HeaderView.swift
//  BrightVibeCalendar
//
//  Created by Rob Timpone on 5/12/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView, NibBased {
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var day1Label: UILabel!
    @IBOutlet weak var day2Label: UILabel!
    @IBOutlet weak var day3Label: UILabel!
    @IBOutlet weak var day4Label: UILabel!
    @IBOutlet weak var day5Label: UILabel!
    @IBOutlet weak var day6Label: UILabel!
    @IBOutlet weak var day7Label: UILabel!
    
    func setSpacingBetweenEachHeaderView(to spacing: CGFloat) {
        stackView.spacing = spacing
    }
    
    func setTextOfLabels(forDays days: [String]) {
        for (index, textForDay) in days.enumerated() {
            if let dayLabel = label(forIndex: index) {
                dayLabel.text = textForDay
            }
        }
    }
    
    func updateFontSizeOfLabels(toFitWidth width: CGFloat) {
        
        var minFontSizeThatFitsWidth = FontSizeCalculator.maximumFontSize
        
        let labels = allLabels()
        for label in labels {
            let fontSize = FontSizeCalculator.calculateFontSize(toFitWidth: width, withText: label.text!, forFont: label.font)
            if fontSize < minFontSizeThatFitsWidth {
                minFontSizeThatFitsWidth = fontSize
            }
        }
        
        for label in labels {
            let oldFont = label.font!
            let newFont = UIFont(name: oldFont.fontName, size: minFontSizeThatFitsWidth)
            label.font = newFont
        }
    }
}

private extension HeaderView {
    
    func label(forIndex index: Int) -> UILabel? {
        
        let labels = allLabels()
        guard index < labels.count else {
            return nil
        }
        
        return labels[index]
    }
    
    func allLabels() -> [UILabel] {
        return [day1Label, day2Label, day3Label, day4Label, day5Label, day6Label, day7Label]
    }
}
