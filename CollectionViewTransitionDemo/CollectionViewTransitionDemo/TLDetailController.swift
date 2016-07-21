//
//  TLDetailController.swift
//  CollectionViewTransitionDemo
//
//  Created by Andrew on 16/7/21.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit


class TLDetailController: UIViewController,UICollectionViewDelegate {
    
    var dataSource:UICollectionViewDataSource!
    
    var collectionView:UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white()
        initView()
    }
    
    func initView() -> Void {
        
        let rect = CGRect(x: 0, y: 0, width: screen_width, height: screen_height)
        
        
        let smallwidth:CGFloat = (screen_width-2)/2
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.itemSize = CGSize(width: smallwidth, height: smallwidth)
        
        collectionView = UICollectionView(frame: rect, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        self.view.addSubview(collectionView)
        
        collectionView.backgroundColor = UIColor.white()
        
        collectionView.register(DataSourceCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    
    
    //MARK: - UICollectionview delegate
   

 

}
