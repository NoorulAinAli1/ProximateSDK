//
//  MerchantTableViewController.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 27/11/2016.
//  Copyright © 2016 ProximateiOSSDK. All rights reserved.
//

import UIKit
import SafariServices

class MerchantTableViewController: UITableViewController, MerchantInfoClickDelegate, CampaignInfoClickDelegate, UIAlertViewDelegate {
    private var navBarVisible : Bool = false
    var mMerchant : ObjectMerchant!
    private var pageNumber : NSInteger = 0
    private var mCampaigns : [ObjectCampaign] = []
    private var loadMoreAvailable: Bool = true
    private let merchantHeaderView = ProximateSDKSettings.getBundle().loadNibNamed("MerchantHeaderView", owner: MerchantTableViewController.self, options: nil)!.first as! MerchantHeaderView
    private let storyBoard = UIStoryboard(name: "ProximateSDK", bundle: ProximateSDKSettings.getBundle())

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)

        self.tableView.backgroundColor =  ProximateSDKSettings.psdkViewOptions.viewBackgroundColor
        self.view.backgroundColor =  ProximateSDKSettings.psdkViewOptions.viewBackgroundColor

        self.tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);

        hideNavigationBar()
        
        self.title = mMerchant.merchantName
        setRefreshControl()
        setTableHeaderView()
        callWebservice()
    }
    
    private func setTableHeaderView(){
        self.merchantHeaderView.frame = CGRectMake(0, 0, self.view.frame.width, ProximateSDKSettings.psdkViewOptions.headerHeight)//self.view.frame.height*0.5)
        self.merchantHeaderView.setMerchant(mMerchant)
        self.merchantHeaderView.delegate = self
        self.tableView.tableHeaderView = self.merchantHeaderView
    }
    
    func didClickMerchantShare() {
        let shareText = String(format: "psdk_merchant_share".localized, arguments: [self.mMerchant.merchantName, self.mMerchant.merchantName, ProximateSDK.getAppName() ])

        self.showShareViewController(shareText)
    }
    
    func didClickMerchantPhone() {
        let msgStr = String(format: "psdk_alert_app_wants_to_call".localized, ProximateSDK.getAppName(),  mMerchant.getPhoneNumber())

        let callAlert : UIAlertView = UIAlertView(title: ProximateSDK.getAppName(), message: msgStr, delegate: self, cancelButtonTitle: "psdk_button_cancel".localized, otherButtonTitles: "psdk_button_call".localized)
        callAlert.tag = 99
        callAlert.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.tag == 99 && buttonIndex == 1 {
            callMerchant()
        }
    }

    private func callMerchant(){
        let url:NSURL = NSURL(string: "tel://\(mMerchant.getPhoneNumber())")!
        UIApplication.sharedApplication().openURL(url)
    }
    
    func didClickMerchantLocation() {
        let vC = storyBoard.instantiateViewControllerWithIdentifier("MerchantMapViewController") as! MerchantMapViewController
        vC.mMerchant = mMerchant
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    func didClickMerchantWebsite() {
        let urlToOpen = NSURL(string: mMerchant.getMerchantWebsite())!
        if #available(iOS 9.0, *) {
            let svc = SFSafariViewController(URL: urlToOpen)
            self.presentViewController(svc, animated: true, completion: nil)
        } else {
            UIApplication.sharedApplication().openURL(urlToOpen)
        }
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
    
    func didClickOnCampaign(campaign: ObjectCampaign) {
        didSelectCampaign(campaign)
    }
    
    private func showShareViewController(shareText : String){
        let activityVC = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        activityVC.completionWithItemsHandler = {
            (activity, shareSuccess, items, error) in
            DebugLogger.debugLog("Activity: \(activity) Success: \(shareSuccess) Items: \(items) Error: \(error)")
        }
        self.presentViewController(activityVC, animated: true, completion: nil)
    }
    
    private func setRefreshControl(){
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.tintColor = ProximateSDKSettings.psdkViewOptions.primaryColor
        self.refreshControl!.addTarget(self, action: #selector(MerchantTableViewController.handleRefresh), forControlEvents: UIControlEvents.ValueChanged)
        
        self.tableView.addSubview(self.refreshControl!)
        self.refreshControl!.beginRefreshing()
    }
    
    private func hideNavigationBar(){
        self.navBarVisible = false
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.barTintColor =  UIColor.clearColor()

        self.title = ""
    }
    
    private func showNavigationBar(){
        self.navBarVisible = true
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = self.merchantHeaderView.getAverageColor()
        self.title = mMerchant.merchantName
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)

        ProximateSDK.getScreenInteractionDelegate()?.screenInteracted()
        if self.navBarVisible {
            showNavigationBar()
        } else {
            hideNavigationBar()
        }
    }
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        ProximateSDK.getScreenInteractionDelegate()?.screenInteracted()
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
//        DebugLogger.debugLog("scrollViewDidScroll \(scrollView.contentOffset)")
//        DebugLogger.debugLog("self.view.frame.width \(self.view.frame.width)")
        if (scrollView.contentOffset.y  > (self.view.frame.width/2)) {
            showNavigationBar()
        } else {
            hideNavigationBar()
        }
    }
    
    @objc private func handleRefresh(){
        initialize()
        callWebservice()
    }
    
    private func initialize(){
        pageNumber = 0
        mCampaigns.removeAll()
    }
    
    func callWebservice(){
        ApiHandler.sharedInstance.getCampaignsForMerchant(mMerchant.getMerchantId(), andPageNumber: pageNumber,  completion:({
            campaigns in
            self.mCampaigns.appendContentsOf(campaigns)
            self.loadMoreAvailable = (campaigns.count != 0)
            self.reloadList()
        }))
    }
    
    private func reloadList(){
        //                DebugLogger.debugLog("campaigns \(campaigns)")
        pageNumber += 1
        
        mCampaigns.sortInPlace { $0.getExpiryTime().compare($1.getExpiryTime()) == .OrderedAscending }
        
        self.refreshControl!.endRefreshing()
        self.tableView.reloadData()
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
        if mCampaigns.count == 0 {
            return 1
        } else {
            let addLoadMoreRow = self.loadMoreAvailable && mCampaigns.count > 0 ? 1 : 0
            return mCampaigns.count + addLoadMoreRow
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if mCampaigns.count == 0 {
            return ProximateSDKSettings.psdkViewOptions.cardHeight * 0.7
        } else {
             return indexPath.row < mCampaigns.count ? ProximateSDKSettings.psdkViewOptions.cardHeight : 100
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if mCampaigns.count == 0 {
            
            let cellnib  = ProximateSDKSettings.getBundle().loadNibNamed("EmptyTableViewCell", owner:self, options: nil)![0] as! EmptyTableViewCell
            cellnib.setEmptyText("psdk_text_empty_no_campaigns_for_merchant".localized)
            return cellnib
        } else {
            
            if indexPath.row < mCampaigns.count {
                let cell = tableView.dequeueReusableCellWithIdentifier("CampaignCell", forIndexPath: indexPath) as! CampaignTableViewCell
                cell.setCampaign(mCampaigns[indexPath.row])
                cell.delegate = self
                return cell
            } else {
                let cellnib  = ProximateSDKSettings.getBundle().loadNibNamed("LoadMoreTableViewCell", owner:self, options: nil)![0] as! LoadMoreTableViewCell
                loadMore()
            
                return cellnib
            }
        }
    }
    
    private func didSelectCampaign(campaign : ObjectCampaign){
        let vC = storyBoard.instantiateViewControllerWithIdentifier("CampaignViewController") as! CampaignViewController
        vC.mCampaign = campaign
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        didSelectCampaign(mCampaigns[indexPath.row])
    }
    
    func  loadMore() {
        callWebservice()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
//        self.navigationController?.navigationBar.translucent = false
//        self.navigationController?.navigationBar.barTintColor = ProximateSDKSettings.psdkViewOptions.primaryColor
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
