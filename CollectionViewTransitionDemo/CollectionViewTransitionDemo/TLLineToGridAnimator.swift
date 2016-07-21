//
//  TLLineToGridAnimator.swift
//  CollectionViewTransitionDemo
//
//  Created by Andrew on 16/7/21.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit

class TLLineToGridAnimator: NSObject,UIViewControllerAnimatedTransitioning {
    var fromCollectionView:UICollectionView!
    
    var transitionLayout:UICollectionViewTransitionLayout!
    var startTime:TimeInterval!
    var endTime:TimeInterval!
    var timer:Timer!
    
    var transitionContext:UIViewControllerContextTransitioning!
    var toCollectionView:UICollectionView!
    
    
    //MARK: -  Animated Transitioning
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let inView = transitionContext.containerView()
        
        let fromVc = transitionContext.viewController(forKey: UITransitionContextFromViewControllerKey)
        let fromView = fromVc?.view
        
        
        let toVc = transitionContext.viewController(forKey: UITransitionContextToViewControllerKey) as! TLDetailController
        let toView = toVc.view
        
        self.toCollectionView = toVc.collectionView
        
        
        let initialRect  = inView.window?.convert(fromCollectionView.frame, to: fromCollectionView.superview)
        let finalRect = transitionContext.finalFrame(for: toVc)
        
        
        let toLayout = toCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        let currentLayout = fromCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        
        let currentLayoutCopy = UICollectionViewFlowLayout()
        currentLayoutCopy.itemSize = currentLayout.itemSize
        currentLayoutCopy.sectionInset = currentLayout.sectionInset
        currentLayoutCopy.minimumLineSpacing = currentLayout.minimumLineSpacing
        currentLayoutCopy.minimumInteritemSpacing = currentLayout.minimumInteritemSpacing
        currentLayoutCopy.scrollDirection = currentLayout.scrollDirection
        
        self.fromCollectionView.setCollectionViewLayout(currentLayoutCopy, animated: true)
        
        var contentInset = toCollectionView.contentInset
        
        let oldBottomInset = contentInset.bottom
        contentInset.bottom = finalRect.height - (toLayout.itemSize.height+toLayout.sectionInset.bottom+toLayout.sectionInset.top)
        
        self.toCollectionView.contentInset = contentInset
        self.toCollectionView.setCollectionViewLayout(currentLayout, animated: true)
        
        toView?.frame = initialRect!
        
        inView.insertSubview(toView!, aboveSubview: fromView!)
        
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            
            toView?.frame = finalRect
            self.toCollectionView.performBatchUpdates({
                
                self.toCollectionView.setCollectionViewLayout(toLayout, animated: true)
                
                }, completion: { (finished) in
                    self.toCollectionView.contentInset = UIEdgeInsetsMake(contentInset.top,
                                                                          contentInset.left,
                                                                          oldBottomInset,
                                                                          contentInset.right);
            })
            
            }) { (finished) in
                transitionContext.completeTransition(true)
        }
        
        
    }
    
    
}
