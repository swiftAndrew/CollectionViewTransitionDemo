//
//  DataSourceCell.swift
//  CollectionViewTransitionDemo
//
//  Created by Andrew on 16/7/21.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit

class DataSourceCell: UICollectionViewCell {
    var lb:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        lb = UILabel(frame: CGRect(x: 10, y: 5, width: 100, height: 20))
        lb.textColor = UIColor.white()
        self.addSubview(lb)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
