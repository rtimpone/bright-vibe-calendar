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
    
    enum CellState {
        case selected
        case unselected
    }
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var circleView: UIView!
    
    func updateForState(_ state: CellState) {
        switch state {
        case .selected:
            circleView.isHidden = false
            dayLabel.textColor = UIColor.white
        case .unselected:
            circleView.isHidden = true
            dayLabel.textColor = Colors.purpleColor
        }
    }
}

struct Colors {
    
    static let purpleColor = color(forHex: "#5C6CC0")
    
    private static func color(forHex hexString: String) -> UIColor {
        
        var tempHexString = hexString
        tempHexString = tempHexString.replacingOccurrences(of: "#", with: "")
        
        var rgbValue: UInt32 = 0
        Scanner(string: tempHexString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
