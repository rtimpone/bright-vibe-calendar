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
    
    @IBOutlet weak var headerCollectionView: UICollectionView!
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    
    var headerHandler = HeaderCollectionViewHandler()
    var collectionViewHandler = CalendarCollectionViewHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerHandler.setupWith(collectionView: headerCollectionView)
        collectionViewHandler.setupWith(collectionView: calendarCollectionView, delegate: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerHandler.updateCollectionViewLayout()
        collectionViewHandler.updateCollectionViewLayout()
    }
}

extension CalendarViewController: CalendarCollectionViewHandlerDelegate {
    
    func didSelectItem(_ item: Int) {
        print("user selected item '\(item)'")
    }
}
