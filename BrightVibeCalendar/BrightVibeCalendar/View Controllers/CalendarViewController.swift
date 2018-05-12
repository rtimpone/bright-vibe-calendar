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
    
    var collectionViewHandler = CalendarCollectionViewHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewHandler.setupWith(collectionView: collectionView, delegate: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionViewHandler.updateCollectionViewLayout()
    }
}

extension CalendarViewController: CalendarCollectionViewHandlerDelegate {
    
    func didSelectItem(_ item: Int) {
        print("user selected item '\(item)'")
    }
}
