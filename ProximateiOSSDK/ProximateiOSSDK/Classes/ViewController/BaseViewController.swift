//
//  BaseViewController.swift
//  Pods
//
//  Created by NoorulAinAli on 09/12/2016.
//
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ProximateSDKSettings.psdkViewOptions.viewBackgroundColor

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = false
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)

        if ProximateSDKSettings.psdkNavBarHasImage  {
            self.navigationController?.navigationBar.setBackgroundImage(ProximateSDKSettings.psdkViewOptions.navigationBarImage, forBarMetrics: UIBarMetrics.Default)
        } else {
            self.navigationController?.view.backgroundColor = ProximateSDKSettings.psdkViewOptions.primaryColor
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
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
