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
    var registeredNibNames = Set<String>()
    
    func dequeueReusableCell<CellType: NibBased>(ofType type: CellType.Type, for indexPath: IndexPath) -> CellType {
        
        let nibName = CellType.nibName
        
        if !registeredNibNames.contains(nibName) {
            let nib = UINib(nibName: nibName, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: nibName)
            registeredNibNames.insert(nibName)
        }
        
        let dequeuedCell = collectionView.dequeueReusableCell(withReuseIdentifier: nibName, for: indexPath)
        
        guard let castedCell = dequeuedCell as? CellType else {
            fatalError("Unable to cast dequeued cell to type '\(nibName)'")
        }
        
        return castedCell
    }
    
    func updateCollectionViewLayout() {
        collectionView.collectionViewLayout.invalidateLayout()
    }
}
