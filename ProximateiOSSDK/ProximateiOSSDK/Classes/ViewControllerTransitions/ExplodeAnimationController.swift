//
//  ExplodeAnimationController.swift
//  Pods
//
//  Created by NoorulAinAli on 15/12/2016.
//
//

import UIKit

class ExplodeAnimationController: ReversibleAnimationController {

    override func animateTransition(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController, fromView: UIView, toView: UIView) {
        
        // Add the toView to the container
        let containerView : UIView = transitionContext.containerView()!
        containerView.addSubview(toView)
        containerView.sendSubviewToBack(toView)
        
        let size : CGSize = toView.frame.size
        let snapshots : NSMutableArray = NSMutableArray()
        let xFactor : CGFloat = 10.0
        let yFactor : CGFloat = xFactor * size.height / size.width
    
        // snapshot the from view, this makes subsequent snaphots more performant
        let fromViewSnapshot : UIView = fromView.snapshotViewAfterScreenUpdates(false)
       
        // create a snapshot for each of the exploding pieces
        var x : CGFloat = 0.0
        var y : CGFloat = 0.0
        for x = 0.0; x < size.width; x += size.width/xFactor {
            for y = 0.0; x < size.height; x += size.height/yFactor {

                let snapshotRegion : CGRect = CGRectMake(x, y, size.width / xFactor, size.height / yFactor)
                let snapshot : UIView = fromViewSnapshot.resizableSnapshotViewFromRect(snapshotRegion, afterScreenUpdates:false, withCapInsets:UIEdgeInsetsZero)
                snapshot.frame = snapshotRegion
                containerView.addSubview(snapshot)
                snapshots.addObject(snapshot)
            }
        }
        
        containerView.sendSubviewToBack(fromView)
        // animate
        let duration : NSTimeInterval = self.transitionDuration(transitionContext)
        
        UIView.animateWithDuration(duration, animations: {
            for view2 in snapshots  {
                var view = view2 as! UIView
                let xOffset : CGFloat = self.randomFloatBetween(-100.0, andBigNumber: 100.0)
                let yOffset : CGFloat = self.randomFloatBetween(-100.0, andBigNumber: 100.0)
//                view.frame = CGRectOffset(view.frame, xOffset, yOffset);
                view.alpha = 0.0;
                view.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(self.randomFloatBetween(-10.0, andBigNumber:10.0)), 0.01, 0.01);
            }
            
            },  completion: {
                finished in
                for view in snapshots {
                    view.removeFromSuperview()
                }
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
        
    }
    
    func randomFloatBetween(smallNumber : Float, andBigNumber bigNumber: Float) -> CGFloat {
        let diff : Float =  bigNumber - smallNumber
       
        let floatMax = Float(RAND_MAX)
        let randmFloat = Float(arc4random())
        let randm = ((randmFloat % (floatMax + 1)) / floatMax) * diff + smallNumber
        return CGFloat(randm)
    }

}
