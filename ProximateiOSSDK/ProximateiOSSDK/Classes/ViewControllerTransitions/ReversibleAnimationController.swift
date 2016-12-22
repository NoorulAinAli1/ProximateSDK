//
//  ReversibleAnimationController.swift
//  Pods
//
//  Created by NoorulAinAli on 14/12/2016.
//
//

import UIKit

class ReversibleAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    var reverse : Bool!
    var duration : NSTimeInterval!
    
    override init(){
        super.init()
        self.duration = 0.50
    }
    
    func animateTransition(transitionContext : UIViewControllerContextTransitioning, fromVC fromVC : UIViewController, toVC toVC:UIViewController, fromView fromView:UIView, toView toView: UIView) {
    }

    func transitionDuration(transitionContext : UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return self.duration
    }
    
    func animateTransition(transitionContext : UIViewControllerContextTransitioning) {
        let fromVC : UIViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC : UIViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let toView : UIView = toVC.view
        let fromView : UIView = fromVC.view
        
        self.animateTransition(transitionContext, fromVC:fromVC, toVC:toVC, fromView:fromView, toView:toView)
    }
    
}
