//
//  Theme.swift
//  BrightVibeCalendar
//
//  Created by Rob Timpone on 5/17/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation
import UIKit

protocol Theme {
    var backgroundColor: UIColor { get }
    var headerTextColor: UIColor { get }
    var selectedDateColor: UIColor { get }
    var dateTextSelectedColor: UIColor { get }
    var dateTextUnselectedColor: UIColor { get }
}

struct Themes {
    static var standard: Theme {
        return StandardTheme()
    }
}

private enum ColorPalette: String {
    
    case purple
    case mintGreen
    case pink
    case lightPurple
    
    var colorValue: UIColor {
        guard let color = UIColor(named: rawValue) else {
            print("Unable to find color named '\(rawValue)' in the asset catalog")
            return .white
        }
        return color
    }
}

private struct StandardTheme: Theme {
    var backgroundColor: UIColor = ColorPalette.purple.colorValue
    var headerTextColor: UIColor = ColorPalette.mintGreen.colorValue
    var selectedDateColor: UIColor = ColorPalette.pink.colorValue
    var dateTextSelectedColor: UIColor = .white
    var dateTextUnselectedColor: UIColor = ColorPalette.lightPurple.colorValue
}
