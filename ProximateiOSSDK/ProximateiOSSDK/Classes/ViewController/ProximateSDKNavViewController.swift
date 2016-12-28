//
//  ProximateSDKNavViewController.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 02/12/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit

class ProximateSDKNavViewController: UINavigationController, UINavigationControllerDelegate {
    var campaignControllerAnimationController : ReversibleAnimationController!
    var merchantControllerAnimationController : ReversibleAnimationController!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self;

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.campaignControllerAnimationController = PortalAnimationController()
        self.merchantControllerAnimationController = CrossFadeAnimationController()
        
        self.view.backgroundColor = ProximateSDKSettings.psdkViewOptions.viewBackgroundColor
        
        self.navigationBar.tintColor = ProximateSDKSettings.psdkViewOptions.navigationBarTitleColor
        
        let textAttributes =  [NSForegroundColorAttributeName: ProximateSDKSettings.psdkViewOptions.navigationBarTitleColor,
                               NSFontAttributeName : UIFont(name: ProximateSDKSettings.psdkViewOptions.fontRegular, size: 16.0)!]
        self.navigationBar.titleTextAttributes = textAttributes
        UIBarButtonItem.appearance().setTitleTextAttributes(textAttributes, forState: .Normal)
        
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.barStyle = UIBarStyle.Black
        
        if let navBarImage = ProximateSDKSettings.psdkViewOptions.navigationBarImage  {
            ProximateSDKSettings.psdkNavBarHasImage = true
            self.navigationBar.setBackgroundImage(navBarImage, forBarMetrics: UIBarMetrics.Default)
        } else {
            self.navigationBar.barTintColor =  ProximateSDKSettings.psdkViewOptions.primaryColor
            self.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        }

//        NSDictionary *textTitleOptionsHighlighted = [NSDictionary dictionaryWithObjectsAndKeys:
//            [UIColor lightGrayColor], NSForegroundColorAttributeName,
//                                      [UIFont fontWithName:AppConstants.kAppNormalFontName size:11.5f], NSFontAttributeName, nil];
//        [[UIBarButtonItem appearance] setTitleTextAttributes:textTitleOptionsHighlighted forState:UIControlStateHighlighted];
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
    }

    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        if toVC is CampaignViewController {//|| fromVC is CampaignViewController {
            if (self.merchantControllerAnimationController != nil) {
                self.merchantControllerAnimationController.reverse = operation == UINavigationControllerOperation.Pop
            }
            return self.merchantControllerAnimationController;
        } else if toVC is MerchantTableViewController {
            if (self.campaignControllerAnimationController != nil) {
                self.campaignControllerAnimationController.reverse = operation == UINavigationControllerOperation.Pop
            }
            return self.campaignControllerAnimationController;
        } else {
            return nil
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
