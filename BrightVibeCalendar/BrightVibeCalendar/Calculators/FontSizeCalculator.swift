//
//  FontSizeCalculator.swift
//  BrightVibeCalendar
//
//  Created by Rob Timpone on 5/12/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import UIKit

struct FontSizeCalculator {
    
    static let maximumFontSize: CGFloat = 200
    static let minimumFontSize: CGFloat = 4
    
    static func calculateFontSize(toFitWidth width: CGFloat, withText text: String, forFont font: UIFont) -> CGFloat {

        var calculatedFontSize = maximumFontSize
        var doneCalculating = false
        
        while !doneCalculating {
            
            guard let adjustedFont = UIFont(name: font.fontName, size: calculatedFontSize) else {
                fatalError("Could not create font with name \(font.fontName) and size \(calculatedFontSize)")
            }
            
            if adjustedFont.pointSize < minimumFontSize {
                calculatedFontSize = minimumFontSize
                break
            }
            
            let calculatedWidth = calculateWidth(toFitText: text, withFont: adjustedFont)
            
            if calculatedWidth > width {
                calculatedFontSize -= 1
            }
            else {
                doneCalculating = true
            }
        }
        
        return calculatedFontSize
    }
}

private extension FontSizeCalculator {
    
    static func calculateWidth(toFitText text: String, withFont font: UIFont) -> CGFloat {
        
        let attributes = [NSAttributedStringKey.font: font]
        let size = (text as NSString).size(withAttributes: attributes)
        return size.width
    }
}
