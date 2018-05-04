//
//  AutoNibRegisteringCollectionView.swift
//  BrightVibeCalendar
//
//  Created by Rob Timpone on 5/4/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation
import UIKit

protocol NibBased {
    static var nibName: String { get }
}

extension NibBased {
    static var nibName: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    
    private struct AssociatedKeys {
        static var registeredNibBasedCells = "kRegisteredNibBasedCells"
    }
    
    //this allows us to add a stored property of type Set<String> to all UICollectionViews via an extension
    var registeredNibBasedCells: Set<String>? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.registeredNibBasedCells) as? Set<String>
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.registeredNibBasedCells, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(ofType type: T.Type, for indexPath: IndexPath) -> T where T: NibBased {
        
        if registeredNibBasedCells == nil {
            registeredNibBasedCells = Set<String>()
        }
        
        guard let registeredCells = registeredNibBasedCells else {
            fatalError("Unable to access the set of registered nib-based cells")
        }
        
        let className = type.nibName
        if !registeredCells.contains(className) {
            let nib = UINib(nibName: className, bundle: nil)
            register(nib, forCellWithReuseIdentifier: className)
            registeredNibBasedCells?.insert(className)
        }
        
        let dequeuedCell = dequeueReusableCell(withReuseIdentifier: className, for: indexPath)
        
        guard let castedCell = dequeuedCell as? T else {
            fatalError("Unable to cast dequeued cell to type '\(className)'")
        }
        
        return castedCell
    }
}
