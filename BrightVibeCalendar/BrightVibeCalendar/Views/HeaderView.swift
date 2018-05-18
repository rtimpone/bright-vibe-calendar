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
    
    var gradientColor: UIColor = .clear
    var gradientLeftInsetAdjustment: CGFloat = 0
    var gradientRightInsetAdjustment: CGFloat = 0
    
    override func draw(_ rect: CGRect) {
        
        let gradientLayer = CAGradientLayer()
        
        //we want this gradient view to span the entire width of the collection view and
        //not be affected by the content insets because views like the selected date
        //circle view may extend beyond the content size
        
        let x = -gradientLeftInsetAdjustment
        let width = gradientLeftInsetAdjustment + bounds.width + gradientRightInsetAdjustment
        gradientLayer.frame = CGRect(x: x, y: 0, width: width, height: bounds.height * 1.3)
        
        gradientLayer.colors = [gradientColor.cgColor, gradientColor.withAlphaComponent(0).cgColor]
        gradientLayer.locations = [0.5]
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
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
    
    func updateForTheme(_ theme: Theme) {
        
        gradientColor = theme.colors.background
        
        for label in allLabels() {
            label.textColor = theme.colors.headerText
        }
    }
    
    func updateFontSizeOfLabels(toFitWidth width: CGFloat) {
        
        let labels = allLabels()
        let labelTexts = labels.map { $0.text! }
        let font = labels.first!.font!
        let fontSize = FontSizeCalculator.calculateSmallestFontSize(forStrings: labelTexts, toFitInWidth: width, usingFont: font)
        
        for label in labels {
            let oldFont = label.font!
            let newFont = UIFont(name: oldFont.fontName, size: fontSize)
            label.font = newFont
        }
    }
    
    func updateForCollectionViewInsets(_ insets: UIEdgeInsets) {
        gradientLeftInsetAdjustment = insets.left
        gradientRightInsetAdjustment = insets.right
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
