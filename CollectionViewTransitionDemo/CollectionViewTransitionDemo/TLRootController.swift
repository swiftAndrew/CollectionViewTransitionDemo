//
//  TLRootController.swift
//  CollectionViewTransitionDemo
//
//  Created by Andrew on 16/7/21.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit

let screen_width = UIScreen.main().bounds.width
let screen_height = UIScreen.main().bounds.height


private var ContainerCell = "ContainerCell"

class TLRootController: UIViewController,UINavigationControllerDelegate,
UICollectionViewDelegate,UICollectionViewDataSource{
    
    var sourceCollectionView:UICollectionView!
    var dataSources:NSArray!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white()
        
        self.navigationController?.delegate = self
        
        initView()
        initData()
    }

    
    func initView() -> Void {
        
        let rect = CGRect(x: 0, y: 0, width: screen_width, height: screen_height)
        
        
        let smallwidth:CGFloat = (screen_width-5)/6
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.itemSize = CGSize(width: smallwidth, height: smallwidth)
        flowLayout.headerReferenceSize = CGSize(width: screen_width, height: 30)
        
        sourceCollectionView = UICollectionView(frame: rect, collectionViewLayout: flowLayout)
        sourceCollectionView.delegate = self
        sourceCollectionView.dataSource = self
        self.view.addSubview(sourceCollectionView)
        sourceCollectionView.backgroundColor = UIColor.white()
        
        sourceCollectionView.register(TLContainerCell.self, forCellWithReuseIdentifier: ContainerCell)
    }
    
    func initData() -> Void {
        let datasource1 = TLCollectionDataSource(color: UIColor.red(), count: 10)
        let datasource2 = TLCollectionDataSource(color: UIColor.gray(), count: 10)
        let datasource3 = TLCollectionDataSource(color: UIColor.green(), count: 10)
        let datasource4 = TLCollectionDataSource(color: UIColor.blue(), count: 10)
        let datasource5 = TLCollectionDataSource(color: UIColor.orange(), count: 10)
        let datasource6 = TLCollectionDataSource(color: UIColor.purple(), count: 10)
        let datasource7 = TLCollectionDataSource(color: UIColor.yellow(), count: 10)
        
        
        self.dataSources = [datasource1,datasource2,datasource3,
                            datasource4,datasource5,datasource6,datasource7]
    }
    
    
    
    
    
    
    
    
    
    
    
    

}

extension TLRootController{
  
    //MARK: - UICollectionView delegate
    @objc(numberOfSectionsInCollectionView:) func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSources.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    @objc(collectionView:cellForItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContainerCell, for: indexPath)
        
        let childCollectionView = (cell as! TLContainerCell).collectionView
        childCollectionView?.dataSource = self.dataSources[indexPath.section] as! TLCollectionDataSource
        return cell
    }
    
    @objc(collectionView:didSelectItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dvc = TLDetailController()
        dvc.dataSource = collectionView.dataSource
        self.sourceCollectionView = collectionView
        self.navigationController?.pushViewController(dvc, animated: true)
        
    }
    
    
    //MARK: - Navigation
    @objc(navigationController:animationControllerForOperation:fromViewController:toViewController:) func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if (fromVC == self && operation == .push) {
            
           let animator = TLLineToGridAnimator()
            animator.fromCollectionView = sourceCollectionView
//            FJLineToGridAnimator *animator = [[FJLineToGridAnimator alloc] init];
//            animator.fromCollectionView = self.sourceCollectionView;
            return animator;
        }
        else {
            return nil;
        }
    }
    
    
    
    
}
