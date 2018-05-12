//
//  NibBased.swift
//  BrightVibeCalendar
//
//  Created by Rob Timpone on 5/7/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation

protocol NibBased {
    static var nibName: String { get }
}

extension NibBased {
    static var nibName: String {
        return String(describing: self)
    }
}
