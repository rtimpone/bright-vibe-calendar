//
//  CalendarViewController.swift
//  BrightVibeCalendar
//
//  Created by Rob Timpone on 5/4/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation
import UIKit

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource = CollectionViewDataSource()
    var collectionViewDelegate = CollectionViewDelegate()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        collectionViewDelegate.delegate = self
        
        collectionView.dataSource = dataSource
        collectionView.delegate = collectionViewDelegate
        adjustCollectionViewSpacing()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func adjustCollectionViewSpacing() {
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 1
        }
    }
}

extension CalendarViewController: CollectionViewDelegateDelegate {
    
    func didSelectItem(at indexPath: IndexPath) {
        dataSource.selectItem(at: indexPath)
        collectionView.reloadData()
    }
}

class CollectionViewDataSource: NSObject {
    
    private var selectedItem: Int = 1
    
    func selectItem(at indexPath: IndexPath) {
        selectedItem = item(for: indexPath)
    }
    
    func item(for indexPath: IndexPath) -> Int {
        return indexPath.row % 31 + 1
    }
}

extension CollectionViewDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 200
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ofType: DayCell.self, for: indexPath)
        let dayNumber = item(for: indexPath)
        cell.dayLabel.text = "\(dayNumber)"
        let cellState: DayCell.CellState = dayNumber == selectedItem ? .selected : .unselected
        cell.updateForState(cellState)
        return cell
    }
}

protocol CollectionViewDelegateDelegate: class {
    func didSelectItem(at indexPath: IndexPath)
}

class CollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    weak var delegate: CollectionViewDelegateDelegate?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let contentWidth = collectionView.contentSize.width
        let itemsPerRow: CGFloat = 7
        let itemWidth = contentWidth / itemsPerRow
        let itemHeight = itemWidth
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
