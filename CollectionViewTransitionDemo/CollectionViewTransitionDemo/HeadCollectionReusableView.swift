//
//  HeadCollectionReusableView.swift
//  CollectionViewTransitionDemo
//
//  Created by Andrew on 16/7/21.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit

class HeadCollectionReusableView: UICollectionReusableView {
    
    var titlelb:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let rect = CGRect(x: 10, y: 5, width: 100, height: 20)
        titlelb = UILabel(frame: rect)
        self.addSubview(titlelb)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
