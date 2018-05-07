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
    weak var collectionView: UICollectionView!
    private var selectedItem: Int = 1
    
    func setupWith(collectionView: UICollectionView, delegate: CalendarCollectionViewHandlerDelegate) {
        self.collectionView = collectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        self.delegate = delegate
        adjustCollectionViewSpacing()
    }
    
    func updateCollectionViewLayout() {
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

private extension CalendarCollectionViewHandler {
    
    func item(for indexPath: IndexPath) -> Int {
        return indexPath.row % 31 + 1
    }
    
    func adjustCollectionViewSpacing() {
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 1
        }
    }
}

extension CalendarCollectionViewHandler: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 200
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(ofType: DayCell.self, from: collectionView, for: indexPath)
        let dayNumber = item(for: indexPath)
        cell.dayLabel.text = "\(dayNumber)"
        let cellState: DayCell.CellState = dayNumber == selectedItem ? .selected : .unselected
        cell.updateForState(cellState)
        return cell
    }
}

extension CalendarCollectionViewHandler: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItem = item(for: indexPath)
        delegate?.didSelectItem(selectedItem)
        collectionView.reloadData()
    }
}

extension CalendarCollectionViewHandler: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let contentWidth = collectionView.contentSize.width
        let itemsPerRow: CGFloat = 7
        let itemWidth = contentWidth / itemsPerRow
        let itemHeight = itemWidth
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
