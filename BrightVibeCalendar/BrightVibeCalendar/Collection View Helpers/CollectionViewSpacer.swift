//
//  CollectionViewSpacer.swift
//  BrightVibeCalendar
//
//  Created by Rob Timpone on 5/8/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation
import UIKit

struct CollectionViewSpacer {
    
    static func adjustSpacing(for collectionView: UICollectionView) {
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 1
        }
    }
    
    static func sizeForItem(in collectionView: UICollectionView) -> CGSize {
        
        let contentWidth = collectionView.contentSize.width
        let itemsPerRow: CGFloat = 7
        let itemWidth = contentWidth / itemsPerRow
        let itemHeight = itemWidth
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
