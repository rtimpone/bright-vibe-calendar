//
//  ColorPalette.swift
//  BrightVibeCalendar
//
//  Created by Rob Timpone on 5/17/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation
import UIKit

struct ColorPalette {

    static let purple = UIColor(hex: "#101C54")
    static let mintGreen = UIColor(hex: "#2ECDBA")
    static let pink = UIColor(hex: "#FC397F")
    static let lightPurple = UIColor(hex: "#5C6CC0")
}

private extension UIColor {
    
    convenience init(hex: String) {
        
        let hexString = hex.replacingOccurrences(of: "#", with: "")
        
        var uint32Value: UInt32 = 0
        Scanner(string: hexString).scanHexInt32(&uint32Value)
        
        let intValue = Int(uint32Value)
        self.init(hex: intValue)
    }
    
    convenience init(hex: Int) {
        
        let r = CGFloat((hex >> 16) & 0xff) / 255
        let g = CGFloat((hex >> 08) & 0xff) / 255
        let b = CGFloat((hex >> 00) & 0xff) / 255
        
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}
