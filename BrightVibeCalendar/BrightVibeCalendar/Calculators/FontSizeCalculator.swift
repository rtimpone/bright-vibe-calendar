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
        
        let frame = CGRect(x: 0, y: 0, width: width, height: width)
        let sizingLabel = UILabel(frame: frame)
        sizingLabel.text = text
        
        var calculatedFontSize = maximumFontSize
        var foundASizeThatFitsWidth = false
        
        while !foundASizeThatFitsWidth {
            
            let nstext = text as NSString
            
            guard let adjustedFont = UIFont(name: font.fontName, size: calculatedFontSize) else {
                fatalError("Could not create font with name \(font.fontName) and size \(calculatedFontSize)")
            }
            
            if adjustedFont.pointSize < minimumFontSize {
                calculatedFontSize = minimumFontSize
                break
            }
            
            let attributes = [NSAttributedStringKey.font: adjustedFont]
            let calculatedSize = nstext.size(withAttributes: attributes)
            
            if calculatedSize.width > width {
                print("Font with size \(calculatedFontSize) was too large, trying a smaller number")
                calculatedFontSize -= 1
            }
            else {
                print("Font with size \(calculatedFontSize) fits width of \(width)")
                foundASizeThatFitsWidth = true
            }
        }
        
        return calculatedFontSize
    }
}
