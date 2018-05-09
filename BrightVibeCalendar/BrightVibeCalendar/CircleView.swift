//
//  CircleView.swift
//  BrightVibeCalendar
//
//  Created by Rob Timpone on 5/4/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CircleView: UIView {
    
    override func layoutSubviews() {
        layer.cornerRadius = bounds.size.width / 2.0
    }
}
