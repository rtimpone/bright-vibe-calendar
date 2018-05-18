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
    var dates: [Int] = []
    let headerDayLetters = ["S", "M", "T", "W", "T", "F", "S"]
    var fontSizeToUseForCells = FontSizeCalculator.maximumFontSize
    var theme: Theme = .standard
    
    func setupWith(collectionView: UICollectionView, delegate: CalendarCollectionViewHandlerDelegate) {
        
        self.collectionView = collectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        self.delegate = delegate
        
        ItemSpacer.adjustSpacing(for: collectionView)
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }
        
        for i in 0...200 {
            dates.append(i % 31 + 1)
        }
        
        collectionView.backgroundColor = theme.colors.background
    }
    
    func updateCollectionViewLayout() {
        
        collectionView.collectionViewLayout.invalidateLayout()
        
        var datesAsStrings: [String] = []
        for i in 1...31 {
            datesAsStrings.append("\(i)")
        }
        
        let itemSize = ItemSpacer.sizeForItem(in: collectionView)
        let width = itemSize.width / 3
        let tempCell = dequeueReusableCell(ofType: DayCell.self, for: IndexPath(item: 0, section: 0))
        let font = tempCell.dayLabel.font!
        
        fontSizeToUseForCells = FontSizeCalculator.calculateSmallestFontSize(forStrings: datesAsStrings, toFitInWidth: width, usingFont: font)
    }
    
    func resizeCollectionView() {
        collectionView.reloadData()
    }
}

private extension CalendarCollectionViewHandler {
    
    func item(for indexPath: IndexPath) -> Int {
        return dates[indexPath.row]
    }
}

extension CalendarCollectionViewHandler: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 200
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let day = item(for: indexPath)
        let cell = dequeueReusableCell(ofType: DayCell.self, for: indexPath)
        
        let isSelected = (day == selectedItem)
        cell.updateForDay(day, selected: isSelected, fontSize: fontSizeToUseForCells, theme: theme)
        
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
            header.updateForTheme(theme)
            
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
