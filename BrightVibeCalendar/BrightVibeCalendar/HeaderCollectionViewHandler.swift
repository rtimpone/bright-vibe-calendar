//
//  HeaderCollectionViewHandler.swift
//  BrightVibeCalendar
//
//  Created by Rob Timpone on 5/8/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation
import UIKit

class HeaderCollectionViewHandler: CollectionViewHandler {
    
    let days = ["S", "M", "T", "W", "T", "F", "S"]
    
    func setupWith(collectionView: UICollectionView) {
        self.collectionView = collectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        CollectionViewSpacer.adjustSpacing(for: collectionView)
    }
}

extension HeaderCollectionViewHandler: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(ofType: HeaderCell.self, for: indexPath)
        cell.dayLabel.text = days[indexPath.row]
        return cell
    }
}

extension HeaderCollectionViewHandler: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CollectionViewSpacer.sizeForItem(in: collectionView)
    }
}
