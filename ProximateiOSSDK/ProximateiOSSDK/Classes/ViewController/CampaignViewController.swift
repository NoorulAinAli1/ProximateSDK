//
//  CampaignViewController.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 29/11/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit
import SafariServices

class CampaignViewController: UIViewController, CampaignInfoClickDelegate, CampaignStoreDelegate, CampaignActionButtonDelegate, UIAlertViewDelegate, UIScrollViewDelegate {

    var mCampaign : ObjectCampaign!
    private var yIndex : CGFloat = 0.0
    private var verticalSpacing : CGFloat = 10.0
    @IBOutlet var scrollView: UIScrollView!
    var merchantLogo : UIImage!
    private let headingHeight : CGFloat = 40.0
    private let campaignHeaderView = ProximateSDK.getBundle().loadNibNamed("CampaignHeaderView", owner: CampaignViewController.self, options: nil)!.first as! CampaignHeaderView
    private let storyBoard = UIStoryboard(name: "ProximateSDK", bundle: ProximateSDK.getBundle())

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)

        self.scrollView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
        
//        self.tableView.rowHeight = UITableViewAutomaticDimension
//        self.tableView.estimatedRowHeight =  100//self.view.frame.height * 0.5
        
        hideNavigationBar()
        
        self.title = mCampaign.getMerchant().merchantName
        setHeaderView()
        setTitleView()
        setDetailView()
        setTimingView()
        setStoreView()
        setBankView()
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: yIndex)
    }
    
    private func setHeaderView(){
        yIndex = self.view.frame.width*0.65

        DebugLogger.debugLog("1 yIndex \(yIndex)")
        self.campaignHeaderView.frame = CGRectMake(0, 0, self.scrollView.frame.width, yIndex)
        self.campaignHeaderView.setCampaign(mCampaign)
        self.campaignHeaderView.delegate = self
        self.scrollView.insertSubview(self.campaignHeaderView, atIndex: 0)

        yIndex += (verticalSpacing*6)
        DebugLogger.debugLog("2 yIndex \(yIndex)")

        DebugLogger.debugLog("campaignHeaderView \(campaignHeaderView)")

//        self.tableView.tableHeaderView = self.campaignHeaderView
    }
    
    private func setTitleView(){
        let height = self.view.frame.width * 0.25
        DebugLogger.debugLog("3 yIndex \(yIndex)")

        let campaignTitleView = ProximateSDK.getBundle().loadNibNamed("CampaignTitleView", owner: CampaignTitleView.self, options: nil)!.first as! CampaignTitleView
        campaignTitleView.frame = CGRectMake(verticalSpacing, yIndex, self.scrollView.frame.width - (verticalSpacing*2), height)
        campaignTitleView.setCampaign(mCampaign)
        self.scrollView.insertSubview(campaignTitleView, atIndex: 1)
        DebugLogger.debugLog("campaignTitleView \(campaignTitleView)")

        yIndex += (height + verticalSpacing)
    }
    
    private func setDetailView(){
        let height = self.view.frame.width * 0.35
        
        let campaignDetailView = ProximateSDK.getBundle().loadNibNamed("CampaignDetailView", owner: CampaignDetailView.self, options: nil)!.first as! CampaignDetailView
        campaignDetailView.frame = CGRectMake(verticalSpacing, yIndex, self.scrollView.frame.width - (verticalSpacing*2), height)
        campaignDetailView.setCampaignDetail(mCampaign.details, campaignActions: mCampaign.campaignActions ?? [])
        campaignDetailView.actionDelegate = self

        self.scrollView.addSubview(campaignDetailView)
        
        DebugLogger.debugLog("campaignDetailView \(campaignDetailView)")
        yIndex += (height + verticalSpacing)
    }
    
    private func setTimingView(){
        if mCampaign.campaignTimings == nil {return}
        
        DebugLogger.debugLog("count \(mCampaign.campaignTimings?.count)")
        let height = self.view.frame.width * 0.125 * CGFloat(mCampaign.campaignTimings!.count)
        
        let campaignTimingView = ProximateSDK.getBundle().loadNibNamed("CampaignTimingView", owner: CampaignTimingView.self, options: nil)!.first as! CampaignTimingView
        campaignTimingView.frame = CGRectMake(verticalSpacing, yIndex, self.scrollView.frame.width - (verticalSpacing*2), height)
        campaignTimingView.setCampaignTiming(campaignTiming: mCampaign.getTiming() ?? [])
        
        self.scrollView.addSubview(campaignTimingView)
        
        DebugLogger.debugLog("campaignTimingView \(campaignTimingView)")
        yIndex += (height + verticalSpacing)
    }
    
    private func setStoreView(){
        if mCampaign.beacons == nil {return}

        let height = headingHeight + (self.view.frame.width * 0.1 * CGFloat(mCampaign.getStores().count))

        let campaignStoreView = ProximateSDK.getBundle().loadNibNamed("CampaignStoreView", owner: CampaignStoreView.self, options: nil)!.first as! CampaignStoreView
        campaignStoreView.frame = CGRectMake(verticalSpacing, yIndex, self.scrollView.frame.width - (verticalSpacing*2), height)
        campaignStoreView.setCampaignStore(campaignStore: mCampaign.getStores())
        campaignStoreView.storeDelegate = self
        self.scrollView.addSubview(campaignStoreView)
        
        DebugLogger.debugLog("campaignStoreView \(campaignStoreView)")
        yIndex += (height + verticalSpacing)
    }
    
    
    private func setBankView(){
        if mCampaign.campaignCards == nil {return}
        let height = self.view.frame.width * 0.5
        
        let campaignBankView = ProximateSDK.getBundle().loadNibNamed("CampaignBankView", owner: CampaignBankView.self, options: nil)!.first as! CampaignBankView
        campaignBankView.frame = CGRectMake(verticalSpacing, yIndex, self.scrollView.frame.width - (verticalSpacing*2), height)
        campaignBankView.setCampaignBank(campaignBank: mCampaign.campaignCards!)
        self.scrollView.addSubview(campaignBankView)
        
        DebugLogger.debugLog("campaignBankView \(campaignBankView)")
        yIndex += (height + verticalSpacing)
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width, height: yIndex)
//    }
  
    // MARK: - CampaignActionButtonDelegate methods
    
    func didClickActionButton(campaignActionTag: NSInteger) {
        let campaignAction = mCampaign.campaignActions![campaignActionTag]
        
        let actionClass = CAMPAIGN_ACTION_TYPE(rawValue: campaignAction.actionClass)!
        switch actionClass {
        case .IMAGELIST:
            DebugLogger.debugLog("images list")
            let viewController =    self.storyboard!.instantiateViewControllerWithIdentifier("MediaPagerFullScreenViewController") as! MediaPagerFullScreenViewController
            viewController.mediaItem = campaignAction.media
            viewController.screenTitle = campaignAction.actionTitle
            self.navigationController?.pushViewController(viewController, animated: true)
        case .VIDEO:
            DebugLogger.debugLog("video list")
            let viewController =    self.storyboard!.instantiateViewControllerWithIdentifier("VideoCampaignActionViewController") as! VideoCampaignActionViewController
            viewController.mCampaignAction = campaignAction
            self.navigationController?.pushViewController(viewController, animated: true)
        case .MAP:
            let viewController =    self.storyboard!.instantiateViewControllerWithIdentifier("MapCampaignActionViewController") as! MapCampaignActionViewController
            viewController.mCampaignAction = campaignAction
            self.navigationController?.pushViewController(viewController, animated: true)
            DebugLogger.debugLog("Map list")
        case .URL:
            let url = campaignAction.getURL()
            if campaignAction.isExternalBrowser() {
                DebugLogger.debugLog("URL external link")
                loadExternalURL(url)
            } else {
                let viewController =    self.storyboard!.instantiateViewControllerWithIdentifier("URLCampaignActionViewController") as! URLCampaignActionViewController
                viewController.mCampaignAction = campaignAction
                self.navigationController?.pushViewController(viewController, animated: true)

                DebugLogger.debugLog("URL internal link")
            }
        default:
            DebugLogger.debugLog("default link")

        }
        

        DebugLogger.debugLog("action is \(campaignActionTag)")
        DebugLogger.debugLog("action-- is \(campaignAction.toString())")
    }

    func loadExternalURL(url : NSURL){
        if #available(iOS 9.0, *) {
            let svc = SFSafariViewController(URL: url)
            self.presentViewController(svc, animated: true, completion: nil)
        } else {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    // MARK: - CampaignStoreDelegate method
    func didClickCampaignStore(campaignStore : ObjectStore){
        if UIApplication.sharedApplication().canOpenURL(NSURL(string: "comgooglemapsurl://")!) {
//            let urlString = "comgooglemapsurl://maps.google.com/maps?q=loc:\(campaignStore.getLocation())+\(campaignStore.storeName!))"
            let urlString = "comgooglemapsurl://maps?q=loc:\(campaignStore.getLocation())+\(campaignStore.storeName!))".mapEncoding()
            UIApplication.sharedApplication().openURL(NSURL(string: urlString)!)
        } else {
            let urlString = "http://www.google.com/maps?q=loc:\(campaignStore.getLocation())+(\(campaignStore.storeName!))".mapEncoding()
            let urlToOpen = NSURL(string: urlString)!
            loadExternalURL(urlToOpen)
        }
    }
    
    // MARK: - CampaignInfoClickDelegate methods

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
    
    // MARK: - CollapsingNavigationBar
    
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        ProximateSDK.getScreenInteractionDelegate()?.screenInteracted()
    }

    // MARK: - Scroll view delegate methods

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        ProximateSDK.getScreenInteractionDelegate()?.screenInteracted()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //        DebugLogger.debugLog("scrollViewDidScroll \(scrollView)")
        if (scrollView.contentOffset.y  > (self.view.frame.width/2)) {
            showNavigationBar()
        } else {
            hideNavigationBar()
        }
//        ProximateSDK.getScreenInteractionDelegate()?.screenInteracted()
    }
    
    // MARK: - Memory Warning

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
//     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
//    
////    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
////        return 200
////    }
//    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        
//        switch indexPath.row {
//        case 0:
//        
//            let cell = tableView.dequeueReusableCellWithIdentifier("CampaignTitleViewCell", forIndexPath: indexPath) as! CampaignTitleViewCell
//            cell.setCampaign(mCampaign)
//            return cell
//        
//        case 1:
//            let cell = tableView.dequeueReusableCellWithIdentifier("CampaignDetailViewCell", forIndexPath: indexPath) as! CampaignDetailTableViewCell
//            cell.setCampaignDetail(mCampaign.details, campaignActions: mCampaign.campaignActions ?? [])
//            cell.actionDelegate = self
//            return cell
//      
//        default:
//            let cellnib  = ProximateSDK.getBundle().loadNibNamed("LoadMoreTableViewCell", owner:self, options: nil)![0] as! LoadMoreTableViewCell
//            return cellnib
//        }
//    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.psdkPrimaryColor()
    }

}
