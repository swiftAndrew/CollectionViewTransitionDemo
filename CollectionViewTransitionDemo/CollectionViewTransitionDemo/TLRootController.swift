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


 var ContainerCell = "ContainerCell"

private let HeaderIdentity = "headerId"

class TLRootController: UIViewController,UINavigationControllerDelegate,
UICollectionViewDelegate,UICollectionViewDataSource,TLContainerCellProtocol{
    
    var sourceCollectionView:UICollectionView!
    var dataSources:NSArray!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white()
        self.title = "转场动画"
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
        flowLayout.itemSize = CGSize(width: screen_width, height: smallwidth*3)
        flowLayout.headerReferenceSize = CGSize(width: screen_width, height: 30)
        
        sourceCollectionView = UICollectionView(frame: rect, collectionViewLayout: flowLayout)
        sourceCollectionView.delegate = self
        sourceCollectionView.dataSource = self
        self.view.addSubview(sourceCollectionView)
        sourceCollectionView.backgroundColor = UIColor.white()
        
        sourceCollectionView.register(TLContainerCell.self, forCellWithReuseIdentifier: ContainerCell)
        
        sourceCollectionView.register(HeadCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderIdentity)
    }
    
    func initData() -> Void {
        let datasource1 = TLCollectionDataSource(color: UIColor.red(), count: 10)
        let datasource2 = TLCollectionDataSource(color: UIColor.gray(), count: 10)
        let datasource3 = TLCollectionDataSource(color: UIColor.green(), count: 10)
        let datasource4 = TLCollectionDataSource(color: UIColor.brown(), count: 10)
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContainerCell, for: indexPath) as? TLContainerCell
        
      
        
        let childCollectionView = cell?.collectionView
        
        let tlDataSource = self.dataSources[indexPath.section] as! TLCollectionDataSource
        childCollectionView?.dataSource = tlDataSource
        
        childCollectionView?.backgroundColor = UIColor.blue()
        cell?.indexPath = indexPath
        cell?.delegate = self
        
        return cell!
    }
    
    @objc(collectionView:viewForSupplementaryElementOfKind:atIndexPath:) func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderIdentity, for: indexPath)
        
        (view as! HeadCollectionReusableView).titlelb.text = "Section\(indexPath.section)"
        
        return view
    }
    
    @objc(collectionView:didSelectItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let tlDataSource = self.dataSources[indexPath.section] as! TLCollectionDataSource
        
        let dvc = TLDetailController()
        dvc.dataSource = tlDataSource
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
    
    
    
    
    
    //MARK: - TLContainerCellProtocol 
    func didCellClick(indexPath: IndexPath?) {
        if(indexPath != nil){
            self.collectionView(sourceCollectionView, didSelectItemAt: indexPath!)
        }

    }
    
    
}
