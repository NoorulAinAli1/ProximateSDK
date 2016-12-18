//
//  CrossFadeAnimationController.swift
//  Pods
//
//  Created by NoorulAinAli on 16/12/2016.
//
//

import UIKit

class CrossFadeAnimationController: ReversibleAnimationController {

    override func animateTransition(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController, fromView: UIView, toView: UIView) {
        
        // Add the toView to the container
        toView.frame = transitionContext.finalFrameForViewController(toVC)
        let containerView : UIView = transitionContext.containerView()!
        containerView.addSubview(toView)
        containerView.sendSubviewToBack(toView)
        
        // animate
        let duration : NSTimeInterval = self.transitionDuration(transitionContext)
        
        UIView.animateWithDuration(duration, animations: {
            fromView.alpha = 0.0;
            },  completion: {
                finished in
                
                if transitionContext.transitionWasCancelled() {
                    fromView.alpha = 1.0;

                } else {
                    fromView.removeFromSuperview()
                    fromView.alpha = 1.0;
                }
             
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })

    }
}
