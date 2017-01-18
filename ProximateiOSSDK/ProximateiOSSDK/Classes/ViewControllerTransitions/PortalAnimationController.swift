//
//  PortalAnimationController.swift
//  Pods
//
//  Created by NoorulAinAli on 14/12/2016.
//
//

import UIKit

class PortalAnimationController: ReversibleAnimationController {
    let zoomScale : CGFloat = 0.8
    
    override func animateTransition(transitionContext : UIViewControllerContextTransitioning, fromVC : UIViewController, toVC:UIViewController, fromView:UIView, toView: UIView) {
    
        if self.reverse.boolValue {
            self.executeReverseAnimation(transitionContext, fromVC:fromVC, toVC:toVC, fromView:fromView, toView:toView)
        } else {
            self.executeForwardsAnimation(transitionContext, fromVC:fromVC, toVC:toVC, fromView:fromView, toView:toView)
        }
    }
    
    func executeForwardsAnimation(transitionContext : UIViewControllerContextTransitioning, fromVC : UIViewController, toVC:UIViewController, fromView:UIView, toView: UIView) {

        let containerView : UIView = transitionContext.containerView()!
    
        // Add a reduced snapshot of the toView to the container
        let toViewSnapshot : UIView = toView.resizableSnapshotViewFromRect(toView.frame, afterScreenUpdates:true, withCapInsets:UIEdgeInsetsZero)
        let scale : CATransform3D = CATransform3DIdentity;
        toViewSnapshot.layer.transform = CATransform3DScale(scale, zoomScale, zoomScale, 1);
        containerView.addSubview(toViewSnapshot)
        containerView.sendSubviewToBack(toViewSnapshot)
    
        // Create two-part snapshots of the from- view
        let topSnapshotRegion : CGRect = CGRectMake(0, 0, fromView.frame.size.width, fromView.frame.size.height/2);
    
        let topHandView : UIView = fromView.resizableSnapshotViewFromRect(topSnapshotRegion,  afterScreenUpdates:false, withCapInsets:UIEdgeInsetsZero)
        topHandView.frame = topSnapshotRegion;
        containerView.addSubview(topHandView)
    
        let bottomSnapshotRegion : CGRect = CGRectMake(0, fromView.frame.size.height/2, fromView.frame.size.width , fromView.frame.size.height/2);
        let bottomHandView : UIView = fromView.resizableSnapshotViewFromRect(bottomSnapshotRegion,  afterScreenUpdates:false, withCapInsets:UIEdgeInsetsZero);
        bottomHandView.frame = bottomSnapshotRegion;
        containerView.addSubview(bottomHandView)
        
        // remove the view that was snapshotted
        fromView.removeFromSuperview()
        
        // animate
        let duration : NSTimeInterval = self.transitionDuration(transitionContext)
    
        UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            // Open the portal doors of the from-view
            topHandView.frame = CGRectOffset(topHandView.frame, 0, -1*topHandView.frame.size.height);
            bottomHandView.frame = CGRectOffset(bottomHandView.frame, 0, bottomHandView.frame.size.height);
            
            // zoom in the to-view
            toViewSnapshot.center = toView.center;
            toViewSnapshot.frame = toView.frame;
            
            },  completion: {
                    finished in
                
                if transitionContext.transitionWasCancelled() {
                    containerView.addSubview(fromView)
                    self.removeOtherViews(fromView)
                } else {
                    containerView.addSubview(toView)
                    self.removeOtherViews(toView)
                }
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }
    
    
    func executeReverseAnimation(transitionContext : UIViewControllerContextTransitioning, fromVC : UIViewController, toVC:UIViewController, fromView:UIView, toView: UIView) {
    
        let containerView : UIView = transitionContext.containerView()!
        containerView.addSubview(fromView)

        // add the to- view and send offscreen (we need to do this in order to allow snapshotting)
        toView.frame = transitionContext.finalFrameForViewController(toVC)
        toView.frame = CGRectOffset(toView.frame, toView.frame.size.width, 0)
        containerView.addSubview(toView)

    // Create two-part snapshots of the to- view
    // snapshot the left-hand side of the to- view
        let topSnapshotRegion : CGRect = CGRectMake(0, 0, fromView.frame.size.width, fromView.frame.size.height/2);
        let topHandView : UIView = toView.resizableSnapshotViewFromRect(topSnapshotRegion,  afterScreenUpdates:true, withCapInsets:UIEdgeInsetsZero)
        topHandView.frame = topSnapshotRegion;
        // reverse animation : start from beyond the edges of the screen
        topHandView.frame = CGRectOffset(topHandView.frame, 0, -1 * topHandView.frame.size.height/2);
        containerView.addSubview(topHandView)

    // snapshot the right-hand side of the to- view
        let bottomSnapshotRegion : CGRect = CGRectMake(0, fromView.frame.size.height/2, fromView.frame.size.width , fromView.frame.size.height/2);
        let bottomHandView : UIView = toView.resizableSnapshotViewFromRect(bottomSnapshotRegion, afterScreenUpdates:true, withCapInsets:UIEdgeInsetsZero)
        bottomHandView.frame = bottomSnapshotRegion;
        // reverse animation : start from beyond the edges of the screen
        bottomHandView.frame = CGRectOffset(bottomHandView.frame, 0, bottomHandView.frame.size.height/2);
        containerView.addSubview(bottomHandView)

        // animate
        let duration : NSTimeInterval = self.transitionDuration(transitionContext)

        UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            // Open the portal doors of the from-view
            topHandView.frame = CGRectOffset(topHandView.frame, 0, topHandView.frame.size.height/2);
            bottomHandView.frame = CGRectOffset(bottomHandView.frame, 0, -1 * bottomHandView.frame.size.height/2);
            
           // Zoom out the from-view
            let scale : CATransform3D = CATransform3DIdentity;
            fromView.layer.transform = CATransform3DScale(scale, self.zoomScale, self.zoomScale, 1);

            
            },  completion: {
                finished in
                
                if transitionContext.transitionWasCancelled() {
                    self.removeOtherViews(fromView)
                } else {
                    self.removeOtherViews(toView)
                    toView.frame = containerView.bounds;
                }

                // inform the context of completion
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
       })

    }
    
    
    // removes all the views other than the given view from the superview
    func removeOtherViews(viewToKeep : UIView) {
        let containerView : UIView = viewToKeep.superview!;
        for view in containerView.subviews {
            if view != viewToKeep {
                view.removeFromSuperview()
            }
        }
    }

}
