//
//  CampViewController.swift
//  Pods
//
//  Created by NoorulAinAli on 17/12/2016.
//
//

import UIKit
import SafariServices

class CampaignViewController:  BaseViewController, CampaignInfoClickDelegate, CampaignStoreDelegate, CampaignActionButtonDelegate, UIAlertViewDelegate, UIScrollViewDelegate {
    
    var mCampaign : ObjectCampaign!
    private let outerPadding : CGFloat  = 10.0
    private let innerPadding : CGFloat  = 4.0

    @IBOutlet var scrollView: UIScrollView!

    private var yIndex : CGFloat = 40.0
    @IBOutlet var view0 : UIView!
    @IBOutlet var view1 : UIView!
    @IBOutlet var view2 : UIView!
    @IBOutlet var view3 : UIView!
    @IBOutlet var view4 : UIView!
    @IBOutlet var view5 : UIView!

    @IBOutlet var view0Height : NSLayoutConstraint!
    @IBOutlet var view1Height : NSLayoutConstraint!
    @IBOutlet var view2Height : NSLayoutConstraint!
    @IBOutlet var view3Height : NSLayoutConstraint!
    @IBOutlet var view4Height : NSLayoutConstraint!
    @IBOutlet var view5Height : NSLayoutConstraint!

    private let campaignHeaderView = ProximateSDKSettings.getBundle().loadNibNamed("CampaignHeaderView", owner: CampaignViewController.self, options: nil)!.first as! CampaignHeaderView

    private let storyBoard = UIStoryboard(name: "ProximateSDK", bundle: ProximateSDKSettings.getBundle())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.backgroundColor = ProximateSDKSettings.getViewOptions().viewBackgroundColor
        
        self.scrollView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
        
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
        
        yIndex = self.view.frame.height*0.5//*0.65
        
        DebugLogger.debugLog("1 yIndex \(yIndex)")

        self.campaignHeaderView.frame = view0.bounds
        campaignHeaderView.setCampaign(mCampaign)
        campaignHeaderView.delegate = self
        self.view0.addSubview(campaignHeaderView)
        view0Height.constant = yIndex
        campaignHeaderView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        

        yIndex += outerPadding
        DebugLogger.debugLog("2 yIndex \(yIndex)")
        
        DebugLogger.debugLog("campaignHeaderView \(campaignHeaderView)")
    }
    
    private func setTitleView(){
        
        DebugLogger.debugLog("3 yIndex \(yIndex)")
        
        let campaignTitleView = CampaignTitleView(frame: CGRectInset(view1.bounds, outerPadding, outerPadding), withInnerPadding: innerPadding)
        self.view1.addSubview(campaignTitleView)
        
        campaignTitleView.setCampaign(mCampaign, forWidth: self.view.frame.width)
        
        let height = campaignTitleView.getContentHeight()
        
        DebugLogger.debugLog("3 yIndex \(yIndex)")
        
        view1Height.constant = height
        campaignTitleView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        DebugLogger.debugLog("campaignTitleView \(campaignTitleView)")
        
        yIndex += view1Height.constant
        yIndex += outerPadding

    }
    
    private func setDetailView(){
        //        var height = self.view.frame.width * 0.35
        
        let campaignDetailView = CampaignDetailView(frame: view2.bounds)
        campaignDetailView.setCampaignDetail(mCampaign.details, campaignActions: mCampaign.campaignActions ?? [])
        campaignDetailView.actionDelegate = self
        
        self.view2.addSubview(campaignDetailView)
        
        view2Height.constant = campaignDetailView.getContentHeight()
        campaignDetailView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        DebugLogger.debugLog("campaignDetailView \(campaignDetailView)")
        yIndex += view2Height.constant
        yIndex += outerPadding

        DebugLogger.debugLog("campaignDetailView yIndex \(yIndex)")
        
    }
    
    private func setTimingView(){
        if mCampaign.campaignTimings == nil {
            view3Height.constant = 0
            return
        }
        
        DebugLogger.debugLog("count \(mCampaign.campaignTimings?.count)")
        
        let campaignTimingView = CampaignTimingView(frame: view3.bounds, campaignTiming: mCampaign.getTiming() ?? [])//ProximateSDKSettings.getBundle().loadNibNamed("CampaignStoreView", owner: CampaignStoreView, options: nil)!.first as! CampaignStoreView
//ProximateSDKSettings.getBundle().loadNibNamed("CampaignTimingView", owner: CampaignTimingView.self, options: nil)!.first as! CampaignTimingView
//        campaignTimingView.frame = CGRectMake(0, yIndex, self.scrollView.frame.width, height)
        
        self.view3.addSubview(campaignTimingView)
        view3Height.constant = campaignTimingView.getContentHeight()

        DebugLogger.debugLog("campaignTimingView \(campaignTimingView)")
        yIndex += view3Height.constant
        yIndex += outerPadding

    }
    
    private func setStoreView(){
        if mCampaign.beacons == nil {
            view4Height.constant = 0
            return
        }
        
        DebugLogger.debugLog("setStoreView yIndex \(yIndex)")
        
        let campaignStoreView = CampaignStoreView(frame: view4.bounds, campaignStore: mCampaign.getStores())//ProximateSDKSettings.getBundle().loadNibNamed("CampaignStoreView", owner: CampaignStoreView, options: nil)!.first as! CampaignStoreView
                campaignStoreView.storeDelegate = self
        self.view4.addSubview(campaignStoreView)
        view4Height.constant = campaignStoreView.getContentHeight()
        campaignStoreView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        

        DebugLogger.debugLog("campaignStoreView \(campaignStoreView)")
        yIndex += view4Height.constant
        yIndex += outerPadding

    }
    
    
    private func setBankView(){
        if mCampaign.campaignCards == nil {
            view5Height.constant = 0
            return
        }
        let campaignBankView = CampaignBankView(frame: view5.bounds, campaignBank: mCampaign.campaignCards!)
        self.view5.addSubview(campaignBankView)
        
        view5Height.constant = campaignBankView.getContentHeight()

        DebugLogger.debugLog("campaignBankView \(campaignBankView)")
        yIndex += view5Height.constant
        yIndex += outerPadding
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
    
    func didClickOnCampaign(campaign : ObjectCampaign){
        let viewController =    self.storyboard!.instantiateViewControllerWithIdentifier("MediaPagerFullScreenViewController") as! MediaPagerFullScreenViewController
        viewController.mediaItem = campaign.getMedia()
        viewController.screenTitle = campaign.title
        self.navigationController?.pushViewController(viewController, animated: true)
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
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = ProximateSDKSettings.getViewOptions().primaryColor
    }
}
