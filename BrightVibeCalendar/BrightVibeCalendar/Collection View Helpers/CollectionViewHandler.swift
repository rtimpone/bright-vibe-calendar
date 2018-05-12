//
//  CollectionViewHandler.swift
//  BrightVibeCalendar
//
//  Created by Rob Timpone on 5/7/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewHandler: NSObject {
    
    weak var collectionView: UICollectionView!
    var registeredCellNibNames = Set<String>()
    var registeredSupplementaryViewNibNames = Set<String>()
    
    func dequeueReusableCell<CellType: NibBased>(ofType type: CellType.Type, for indexPath: IndexPath) -> CellType {
        
        let nibName = CellType.nibName
        
        if !registeredCellNibNames.contains(nibName) {
            let nib = UINib(nibName: nibName, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: nibName)
            registeredCellNibNames.insert(nibName)
        }
        
        let dequeuedCell = collectionView.dequeueReusableCell(withReuseIdentifier: nibName, for: indexPath)
        
        guard let castedCell = dequeuedCell as? CellType else {
            fatalError("Unable to cast dequeued cell to type '\(nibName)'")
        }
        
        return castedCell
    }
    
    func dequeueSupplementaryView<ViewType: NibBased>(ofType type: ViewType.Type, ofKind kind: String, for indexPath: IndexPath) -> ViewType {
        
        let nibName = ViewType.nibName
        
        if !registeredSupplementaryViewNibNames.contains(nibName) {
            let nib = UINib(nibName: nibName, bundle: nil)
            collectionView.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: nibName)
            registeredSupplementaryViewNibNames.insert(nibName)
        }
        
        let dequeuedCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: nibName, for: indexPath)
        
        guard let castedCell = dequeuedCell as? ViewType else {
            fatalError("Unable to cast dequeued supplementary view to type '\(nibName)'")
        }
        
        return castedCell
    }
    
    func updateCollectionViewLayout() {
        collectionView.collectionViewLayout.invalidateLayout()
    }
}
