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
    var navigationControllerAnimationController : ReversibleAnimationController!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self;

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.campaignControllerAnimationController = PortalAnimationController()
        self.navigationControllerAnimationController = CrossFadeAnimationController()
        self.navigationBar.barTintColor =  ProximateSDKSettings.getViewOptions().primaryColor
        
        self.view.backgroundColor = ProximateSDKSettings.getViewOptions().viewBackgroundColor
        
        self.navigationBar.tintColor = ProximateSDKSettings.getViewOptions().navigationBarTintColor
        
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: ProximateSDKSettings.getViewOptions().navigationBarTitleColor,
        NSFontAttributeName : UIFont(name: "Futura", size: 16.0)!]

        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationBar.barStyle = UIBarStyle.Black
        

//        let textTitleOptionsNormal = [NSForegroundColorAttributeName: ProximateSDKSettings.getViewOptions().navigationBarTextColor, NSFontAttributeName : UIFont(name: "Futura", size: 11.0)]

//        [[UINavigationBar appearance] setTitleTextAttributes:textTitleOptions];
//        
//        NSDictionary *textTitleOptionsNormal = [NSDictionary dictionaryWithObjectsAndKeys:
//            [UIColor whiteColor], NSForegroundColorAttributeName,
//                                  [UIFont fontWithName:AppConstants.kAppNormalFontName size:11.5f], NSFontAttributeName, nil];
//        
//        NSDictionary *textTitleOptionsHighlighted = [NSDictionary dictionaryWithObjectsAndKeys:
//            [UIColor lightGrayColor], NSForegroundColorAttributeName,
//                                      [UIFont fontWithName:AppConstants.kAppNormalFontName size:11.5f], NSFontAttributeName, nil];
//        [[UIBarButtonItem appearance] setTitleTextAttributes:textTitleOptionsNormal forState:UIControlStateNormal];
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

        if toVC is MerchantTableViewController {
            if (self.campaignControllerAnimationController != nil) {
                self.campaignControllerAnimationController.reverse = operation == UINavigationControllerOperation.Pop
            }
            return self.campaignControllerAnimationController;
        } else if toVC is CampaignViewController {
            if (self.navigationControllerAnimationController != nil) {
                self.navigationControllerAnimationController.reverse = operation == UINavigationControllerOperation.Pop
            }
            return self.navigationControllerAnimationController;
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
