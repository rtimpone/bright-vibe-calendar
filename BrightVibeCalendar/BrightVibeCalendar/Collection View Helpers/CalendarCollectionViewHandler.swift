//
//  CalendarCollectionViewHandler.swift
//  BrightVibeCalendar
//
//  Created by Rob Timpone on 5/7/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation
import UIKit

protocol CalendarCollectionViewHandlerDelegate: class {
    func didSelectItem(_ item: Int)
}

class CalendarCollectionViewHandler: CollectionViewHandler {
    
    weak var delegate: CalendarCollectionViewHandlerDelegate?
    private var selectedItem: Int = 1
    let headerDayLetters = ["S", "M", "T", "W", "T", "F", "S"]
    
    func setupWith(collectionView: UICollectionView, delegate: CalendarCollectionViewHandlerDelegate) {
        
        self.collectionView = collectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        self.delegate = delegate
        
        ItemSpacer.adjustSpacing(for: collectionView)
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }
    }
}

private extension CalendarCollectionViewHandler {
    
    func item(for indexPath: IndexPath) -> Int {
        return indexPath.row % 31 + 1
    }
}

extension CalendarCollectionViewHandler: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 200
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(ofType: DayCell.self, for: indexPath)
        let day = item(for: indexPath)
        cell.updateForDay(day)
        let cellState: DayCell.CellState = day == selectedItem ? .selected : .unselected
        cell.updateForState(cellState)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            
            let header = dequeueSupplementaryView(ofType: HeaderView.self, ofKind: kind, for: indexPath)
            header.setTextOfLabels(forDays: headerDayLetters)
            header.setSpacingBetweenEachHeaderView(to: ItemSpacer.spacingBetweenItems)
            
            let sizeForHeaderItem = ItemSpacer.sizeForItem(in: collectionView)
            let targetLetterWidth = sizeForHeaderItem.width / 3
            header.updateFontSizeOfLabels(toFitWidth: targetLetterWidth)
            
            return header
            
        default:
            return UICollectionReusableView()
        }
    }
}

extension CalendarCollectionViewHandler: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItem = item(for: indexPath)
        delegate?.didSelectItem(selectedItem)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return ItemSpacer.sizeForItem(in: collectionView)
    }
}

extension CalendarCollectionViewHandler: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return ItemSpacer.sizeForItem(in: collectionView)
    }
}
