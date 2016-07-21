//
//  TLCollectionDataSource.swift
//  CollectionViewTransitionDemo
//
//  Created by Andrew on 16/7/21.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit
 let cellId = "ColorCell"

class TLCollectionDataSource: NSObject,UICollectionViewDataSource {

    var numberOfItems:Int = 0
    var color:UIColor!
    
    var lb:UILabel!
    
    
    init(color:UIColor,count:Int) {
        super.init()
        self.color = color
        self.numberOfItems = count
     }
    
    
    
    //MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? DataSourceCell
    
        cell?.backgroundColor = self.color
        cell?.lb.text = "\(indexPath.section) - \(indexPath.row)"
        return cell!
        
    }
    
}
