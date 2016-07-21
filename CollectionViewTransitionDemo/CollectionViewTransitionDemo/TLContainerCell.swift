//
//  TLContainerCell.swift
//  CollectionViewTransitionDemo
//
//  Created by Andrew on 16/7/21.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit

protocol TLContainerCellProtocol {
    func didCellClick(indexPath:IndexPath?) -> Void;
}

class TLContainerCell: UICollectionViewCell,UICollectionViewDelegate {
    
    var collectionView:UICollectionView?
    
    var delegate:TLContainerCellProtocol?
    var indexPath:IndexPath?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let smallwidth:CGFloat = (screen_width-5)/6
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.itemSize = CGSize(width: smallwidth, height: smallwidth)
        let rect = CGRect(x: 0, y: 0, width: screen_width, height:smallwidth*2+1)
        collectionView = UICollectionView(frame: rect, collectionViewLayout: flowLayout)
        collectionView?.delegate = self
        self.addSubview(collectionView!)
        
        
        collectionView?.register(DataSourceCell.self, forCellWithReuseIdentifier: cellId)
        
        self.backgroundColor = UIColor.orange()
    }
    
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - UICollectionView delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didCellClick(indexPath: self.indexPath)
    }
}
