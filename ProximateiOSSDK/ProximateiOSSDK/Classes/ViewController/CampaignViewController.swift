//
//  CampViewController.swift
//  Pods
//
//  Created by NoorulAinAli on 17/12/2016.
//
//

import UIKit
import SafariServices

internal enum CAMPAIGN_ACTION_TYPE : String {
    case IMAGELIST  = "IMAGELIST"
    case VIDEO      = "VIDEO"
    case URL        = "URL"
    case MAP        = "MAP"
    case REDEEM     = "REDEEM"
}

class CampaignViewController:  UIViewController, CampaignInfoClickDelegate, CampaignStoreDelegate, CampaignActionButtonDelegate, UIAlertViewDelegate, UIScrollViewDelegate{
    
    var mCampaign : ObjectCampaign!
    private let outerPadding : CGFloat  = ProximateSDKSettings.psdkViewOptions.outerPadding
    private let innerPadding : CGFloat  = ProximateSDKSettings.psdkViewOptions.innerPadding
    @IBOutlet var scrollView: UIScrollView!
    private var navBarVisible : Bool = false

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

    @IBOutlet var viewSpacing : [NSLayoutConstraint]!
    
    private let campaignHeaderView = ProximateSDKSettings.getBundle().loadNibNamed("CampaignHeaderView", owner: CampaignViewController.self, options: nil)!.first as! CampaignHeaderView
    private let storyBoard = UIStoryboard(name: "ProximateSDK", bundle: ProximateSDKSettings.getBundle())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ProximateSDKSettings.psdkViewOptions.viewBackgroundColor
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    
        self.scrollView.backgroundColor = ProximateSDKSettings.psdkViewOptions.viewBackgroundColor
        self.scrollView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
        
        hideNavigationBar()
        
        self.title = mCampaign.getMerchant().merchantName
        
        setOuterSpacing()
        
        setHeaderView()
        setTitleView()
        
        populateSequentialViews()
    }
    
    private func setOuterSpacing() {
//        for item in self.viewSpacing {
//            item.constant = outerPadding
//        }
    }
    
    private func populateSequentialViews(){
        let viewObjects = [view2, view3, view4, view5]
        let viewObjectsHeight = [view2Height, view3Height, view4Height, view5Height]
        DebugLogger.debugLog("viewObjects \(viewObjects)")
        
        //1 2 3 4
        var index : NSInteger = 0
        for index = 0; index < ProximateSDKSettings.psdkCampaignSectionSequence.count; index += 1 {
            
            let viewSeq = ProximateSDKSettings.psdkCampaignSectionSequence[index]
            DebugLogger.debugLog("viewSeq \(index)")
            let testView = viewObjects[index]
            let viewHeight = viewObjectsHeight[index]
            
            switch viewSeq {
            case .Detail:
                setDetailView(testView, andViewHeight: viewHeight)
            case .Store:
                setStoreView(testView, andViewHeight: viewHeight)
            case .Timing:
                setTimingView(testView, andViewHeight: viewHeight)
            case .Bank:
                setBankView(testView, andViewHeight: viewHeight)
            default:
                DebugLogger.debugLog("here")
            }
        }
        
        yIndex += outerPadding
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: yIndex + 50)
    }
    
    private func setHeaderView(){
        yIndex = ProximateSDKSettings.psdkViewOptions.headerHeight//self.view.frame.height*0.5

        self.campaignHeaderView.frame = view0.bounds
        campaignHeaderView.setCampaign(mCampaign)
        campaignHeaderView.delegate = self
        self.view0.addSubview(campaignHeaderView)
        view0Height.constant = yIndex
        campaignHeaderView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        yIndex += outerPadding
        
    }
    
    private func setTitleView(){
        let campaignTitleView = CampaignTitleView(frame: view1.bounds)
        self.view1.addSubview(campaignTitleView)
        campaignTitleView.setCampaign(mCampaign)
        
        let height = campaignTitleView.getContentHeight()
        
        view1Height.constant = height
        campaignTitleView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        DebugLogger.debugLog("campaignTitleView \(campaignTitleView)")
        
        yIndex += view1Height.constant
        yIndex += outerPadding
    }
    
    private func setDetailView(addView : UIView, andViewHeight addViewHeight : NSLayoutConstraint){
        
        let campaignDetailView = CampaignDetailView(frame: addView.bounds, withDetails: mCampaign.details, withCampaignActions: mCampaign.getActions())
        campaignDetailView.actionDelegate = self
        addView.addSubview(campaignDetailView)
        
        addViewHeight.constant = campaignDetailView.getContentHeight()
        campaignDetailView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        yIndex += addViewHeight.constant
        yIndex += outerPadding
    }
    
    private func setTimingView(addView : UIView, andViewHeight addViewHeight : NSLayoutConstraint){
        if mCampaign.campaignTimings == nil {
            addViewHeight.constant = 0
            return
        }
        DebugLogger.debugLog("count \(mCampaign.campaignTimings?.count)")
        let campaignTimingView = CampaignTimingView(frame: addView.bounds, campaignTiming: mCampaign.getTiming() ?? [])
        
        addView.addSubview(campaignTimingView)
        addViewHeight.constant = campaignTimingView.getContentHeight()
        campaignTimingView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        DebugLogger.debugLog("campaignTimingView \(campaignTimingView)")
        yIndex += addViewHeight.constant
        yIndex += outerPadding
    }
    
    private func setStoreView(addView : UIView, andViewHeight addViewHeight : NSLayoutConstraint){
        if mCampaign.beacons == nil {
            addViewHeight.constant = 0
            return
        }
        
        let campaignStoreView = CampaignStoreView(frame: addView.bounds, campaignStore: mCampaign.getStores())
        campaignStoreView.storeDelegate = self
        addView.addSubview(campaignStoreView)
        addViewHeight.constant = campaignStoreView.getContentHeight()
        campaignStoreView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        yIndex += addViewHeight.constant
        yIndex += outerPadding
    }
    
    private func setBankView(addView : UIView, andViewHeight addViewHeight : NSLayoutConstraint){
        if mCampaign.campaignCards == nil {
            addViewHeight.constant = 0
            return
        }
        let campaignBankView = CampaignBankView(frame: addView.bounds, campaignBank: mCampaign.campaignCards!)
        addView.addSubview(campaignBankView)
        
        addViewHeight.constant = campaignBankView.getContentHeight()
        campaignBankView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]

        DebugLogger.debugLog("campaignBankView \(campaignBankView)")
        yIndex += addViewHeight.constant
        yIndex += outerPadding
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width, height: yIndex)
//    }
    
    // MARK: - CampaignActionButtonDelegate methods
    
    func didClickActionButton(campaignActionTag: NSInteger) {
        let campaignAction = mCampaign.campaignActions![campaignActionTag]
        
        let actionClass = CAMPAIGN_ACTION_TYPE(rawValue: campaignAction.actionClass.uppercaseString)!
        switch actionClass {
        case .IMAGELIST:
            DebugLogger.debugLog("images list")
            let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("MediaPagerFullScreenViewController") as! MediaPagerFullScreenViewController
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
    func didSetCampaignMediaVideo(){
        self.navigationItem.rightBarButtonItem = campaignHeaderView.btnVideo

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
        let msgStr = String(format: "psdk_alert_app_wants_to_call".localized, ProximateSDK.getAppName(), mCampaign.getMerchant().getPhoneNumber())
        let callAlert : UIAlertView = UIAlertView(title: ProximateSDK.getAppName(), message: msgStr, delegate: self, cancelButtonTitle: "psdk_button_cancel".localized, otherButtonTitles: "psdk_button_call".localized)
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
        self.navBarVisible = false
        self.navigationController?.navigationBar.translucent = !self.navBarVisible
        self.navigationController?.navigationBar.barTintColor =  UIColor.clearColor()
        self.title = ""
        
        if self.campaignHeaderView.btnVideo != nil {
            self.navigationItem.rightBarButtonItem = self.campaignHeaderView.btnVideo
        }
    }
    
    private func showNavigationBar(){
        self.navBarVisible = true
        self.navigationController?.navigationBar.translucent = !self.navBarVisible
        self.navigationController?.navigationBar.barTintColor = self.campaignHeaderView.getAverageColor()
        self.title = mCampaign.getMerchant().merchantName
        self.navigationItem.rightBarButtonItem = nil
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)

        ProximateSDK.getScreenInteractionDelegate()?.screenInteracted()
        if self.navBarVisible {
            self.navigationController?.navigationBar.hidden = false
            showNavigationBar()
        } else {
            hideNavigationBar()
        }
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
//        self.navigationController?.navigationBar.translucent = false
//        self.navigationController?.navigationBar.barTintColor = ProximateSDKSettings.psdkViewOptions.primaryColor
    }
}
