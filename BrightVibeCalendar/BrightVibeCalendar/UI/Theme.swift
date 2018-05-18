//
//  Theme.swift
//  BrightVibeCalendar
//
//  Created by Rob Timpone on 5/17/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation
import UIKit

struct Theme {
    
    var colors: Colors
    
    struct Colors {
        
        var background: UIColor
        var headerText: UIColor
        var selectedDate: UIColor
        var dateTextSelected: UIColor
        var dateTextUnselected: UIColor
    }
    
    static var standard: Theme = {
        
        let colors = Colors(background: ColorPalette.purple,
                            headerText: ColorPalette.mintGreen,
                            selectedDate: ColorPalette.pink,
                            dateTextSelected: UIColor.white,
                            dateTextUnselected: ColorPalette.lightPurple)
        
        return Theme(colors: colors)
    }()
}
