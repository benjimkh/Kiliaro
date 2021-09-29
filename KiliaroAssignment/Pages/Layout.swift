//
//  Layout.swift
//  KiliaroAssignment
//
//  Created by Benyamin Mokhtarpour on 9/27/21.
//

import Foundation
import UIKit

enum CollectionDisplay {
    case grid
    //OTHER CASES - TO BE EXTENDED FOR FUTURE DEVELOPMENT
}

class CustomCollectionViewFlowLayout : UICollectionViewFlowLayout {
    
    var display : CollectionDisplay = .grid {
        didSet {
            if display != oldValue {
                self.invalidateLayout()
            }
        }
    }
    
    convenience init(display: CollectionDisplay) {
        self.init()
        
        self.display = display
        self.configLayout()
    }
    
    func configLayout() {
        switch display {
        case .grid:
            
            self.scrollDirection = .vertical
            if let collectionView = self.collectionView {
                let optimisedWidth = (collectionView.frame.width) / 3
                self.itemSize = CGSize(width: optimisedWidth , height: optimisedWidth)
            }
        }
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        self.configLayout()
    }
}
