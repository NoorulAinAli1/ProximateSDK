//
//  CampaignTableViewController.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 29/11/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit
import SafariServices

class CampaignTableViewController: UITableViewController, CampaignInfoClickDelegate, UIAlertViewDelegate {

    var mCampaign : ObjectCampaign!
    var merchantLogo : UIImage!
    private let campaignHeaderView = NSBundle.mainBundle().loadNibNamed("CampaignHeaderView", owner: CampaignTableViewController.self, options: nil)!.first as! CampaignHeaderView
    private let storyBoard = UIStoryboard(name: "ProximateSDK", bundle: NSBundle.mainBundle())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
        
        hideNavigationBar()
        
        self.title = mCampaign.getMerchant().merchantName
        setTableHeaderView()
    }
    
    private func setTableHeaderView(){
        self.campaignHeaderView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.width*0.8)
        self.campaignHeaderView.setCampaign(mCampaign)
        self.campaignHeaderView.delegate = self
        self.tableView.tableHeaderView = self.campaignHeaderView
    }
  
    func didClickCampaignShare(shareText: String) {
        let activityVC = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        activityVC.completionWithItemsHandler = {
            (activity, shareSuccess, items, error) in
            DebugLogger.debugLog("Activity: \(activity) Success: \(shareSuccess) Items: \(items) Error: \(error)")
        }
        self.presentViewController(activityVC, animated: true, completion: nil)
    }
    
    func didClickCampaignLocation(campaign: ObjectCampaign) {
        let vC = storyBoard.instantiateViewControllerWithIdentifier("CampaignMapViewController") as! CampaignMapViewController
        vC.mCampaign = campaign
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    func didClickCampaignPhone() {
        let callAlert : UIAlertView = UIAlertView(title: "app_name".localized, message: "App wants to call merchant".localized, delegate: self, cancelButtonTitle: "button_cancel".localized, otherButtonTitles: "button_call".localized)
        callAlert.tag = 99
        callAlert.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if(alertView.tag == 99) {
            if(buttonIndex == 1) {
                callMerchant()
            }
        }
    }
    
    private func callMerchant(){
        let url:NSURL = NSURL(string: "tel://\(mCampaign.getMerchant().getPhoneNumber())")!
        UIApplication.sharedApplication().openURL(url)
    }

    func didClickCampaignWebsite() {
        let urlToOpen = NSURL(string: mCampaign.getMerchant().getMerchantWebsite())!
        if #available(iOS 9.0, *) {
            let svc = SFSafariViewController(URL: urlToOpen)
            self.presentViewController(svc, animated: true, completion: nil)
        } else {
            UIApplication.sharedApplication().openURL(urlToOpen)
        }
    }
    
    private func hideNavigationBar(){
        //        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.view.backgroundColor = UIColor.clearColor()
        self.title = ""
        
    }
    
    private func showNavigationBar(){
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = self.campaignHeaderView.getAverageColor()
        
        //        self.navigationController?.view.backgroundColor = self.campaignHeaderView.getAverageColor()
        self.title = mCampaign.getMerchant().merchantName
    }
    
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        ProximateiOSSDK.getScreenInteractionDelegate()?.screenInteracted()
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        //        DebugLogger.debugLog("scrollViewDidScroll \(scrollView)")
        if (scrollView.contentOffset.y  > (self.view.frame.width/2)) {
            showNavigationBar()
        } else {
            hideNavigationBar()
        }
//        ProximateiOSSDK.getScreenInteractionDelegate()?.screenInteracted()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        if indexPath.row < mCampaigns.count {
//            let cell = tableView.dequeueReusableCellWithIdentifier("CampaignCell", forIndexPath: indexPath) as! CampaignTableViewCell
//            cell.setCampaign(mCampaigns[indexPath.row])
//            return cell
//        } else {
            let cellnib  = NSBundle.mainBundle().loadNibNamed("LoadMoreTableViewCell", owner:self, options: nil)![0] as! LoadMoreTableViewCell
        
            return cellnib
//        }
    }
       
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.psdkPrimaryColor()
    }

}
