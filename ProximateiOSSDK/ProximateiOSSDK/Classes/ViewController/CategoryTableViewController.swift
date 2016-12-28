//
//  CategoryTableViewController.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 24/11/2016.
//  Copyright © 2016 ProximateiOSSDK. All rights reserved.
//

import UIKit

internal class CategoryTableViewController: UITableViewController, SearchDelegate, CampaignInfoClickDelegate, UIViewControllerTransitioningDelegate {    var navigationControllerAnimationController : ReversibleAnimationController!
    var mCategory : ObjectCategory!
    var parentNavigationController : UINavigationController?

    private var pageNumber : NSInteger = 0
    private var mMerchantGroup : [ObjectMerchantGroup] = []
    private var searchString : String! = ""
    private var loadMoreAvailable: Bool = true
    private let storyBoard = UIStoryboard(name: "ProximateSDK", bundle: ProximateSDKSettings.getBundle())

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.transitioningDelegate = self;
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationControllerAnimationController = PortalAnimationController()
        self.tableView.contentInset = UIEdgeInsetsMake(ProximateSDKSettings.psdkTabOptions.menuHeight, 0, 0, 0);

        self.view.backgroundColor = ProximateSDKSettings.psdkViewOptions.viewBackgroundColor
        self.tableView.backgroundColor = ProximateSDKSettings.psdkViewOptions.viewBackgroundColor

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)

        self.title = mCategory.getCategoryTitle()

        self.refreshControl = UIRefreshControl()
        self.refreshControl!.tintColor = ProximateSDKSettings.psdkViewOptions.primaryColor
        self.refreshControl!.addTarget(self, action: #selector(CategoryTableViewController.handleRefresh), forControlEvents: UIControlEvents.ValueChanged)
        
        self.tableView.addSubview(self.refreshControl!)
        self.refreshControl!.beginRefreshing()
//        callWebservice()
    }
    
    @objc private func handleRefresh(){
        initialize()
        callWebservice()
    }
    
    private func initialize(){
        pageNumber = 0
        mMerchantGroup.removeAll()
    }
    
    func didClickOnSearch(search : String){
        DebugLogger.debugLog("serach \(search)")
        self.searchString = search
        handleRefresh()
    }

    func didCancelSearch(){
        initialize()
        self.searchString = ""
        
        DebugLogger.debugLog("cancel")
        callWebservice()
    }
    
    func callWebservice(){
        if mCategory.prodCategoryId == 0 {
            ApiHandler.sharedInstance.getAllCampaigns(searchString!, andPageNumber: pageNumber,  completion:({
                campaigns in
                self.mMerchantGroup.appendContentsOf(campaigns)
                self.loadMoreAvailable = (campaigns.count != 0)

                self.reloadList()
            }))
        } else {
            ApiHandler.sharedInstance.getCampaignsForCategory(searchString!, andCategoryId: (mCategory.prodCategoryId?.integerValue)!, andPageNumber: pageNumber,  completion:({
                campaigns in
                self.mMerchantGroup.appendContentsOf(campaigns)
                self.loadMoreAvailable = (campaigns.count != 0)
                self.reloadList()
            }))
        }
    }
    
    func didClickCampaignShare(shareText: String) {
        self.showShareViewController(shareText)
    }
    
    func didClickCampaignLocation(campaign: ObjectCampaign) {
        let vC = storyBoard.instantiateViewControllerWithIdentifier("CampaignMapViewController") as! CampaignMapViewController
        vC.mCampaign = campaign
        self.parentNavigationController?.pushViewController(vC, animated: true)
    }
    
    private func showShareViewController(shareText : String){
        let activityVC = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        activityVC.completionWithItemsHandler = {
            (activity, shareSuccess, items, error) in
            DebugLogger.debugLog("Activity: \(activity) Success: \(shareSuccess) Items: \(items) Error: \(error)")
        }
        
        self.presentViewController(activityVC, animated: true, completion: nil)
    }
    
    private func reloadList(){
        pageNumber += 1
        mMerchantGroup.sort({ $0.sortOrder.integerValue > $1.sortOrder.integerValue })
        
        self.refreshControl!.endRefreshing()
        self.tableView.reloadData()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        ProximateSDK.getScreenInteractionDelegate()?.screenInteracted()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        ProximateSDK.getScreenInteractionDelegate()?.screenInteracted()
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        DebugLogger.debugLog("scrollViewDidScroll")
//        ProximateSDK.getScreenInteractionDelegate()?.screenInteracted()
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mMerchantGroup.count == 0 {
            return 1
        } else {
            let addLoadMoreRow = self.loadMoreAvailable && mMerchantGroup.count > 0 ? 1 : 0
            return mMerchantGroup.count + addLoadMoreRow
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if mMerchantGroup.count == 0 {
            return ProximateSDKSettings.psdkViewOptions.cardHeight * 0.7
        } else {
            return indexPath.row < mMerchantGroup.count ? ProximateSDKSettings.psdkViewOptions.cardHeight : 100
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        if mMerchantGroup.count == 0 {

            let cellnib  = ProximateSDKSettings.getBundle().loadNibNamed("EmptyTableViewCell", owner:self, options: nil)![0] as! EmptyTableViewCell
            cellnib.setEmptyText("psdk_text_empty_no_active_campaigns".localized)
            return cellnib
        } else {
            if indexPath.row < mMerchantGroup.count {
                let cell = tableView.dequeueReusableCellWithIdentifier("MerchantCell", forIndexPath: indexPath) as! MerchantTableViewCell
                cell.setMerchantGroup(mMerchantGroup[indexPath.row])
                cell.delegate = self
                return cell
            } else {
                let cellnib  = ProximateSDKSettings.getBundle().loadNibNamed("LoadMoreTableViewCell", owner:self, options: nil)![0] as! LoadMoreTableViewCell
                loadMore()
        
                return cellnib
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vC = storyBoard.instantiateViewControllerWithIdentifier("MerchantTableViewController") as! MerchantTableViewController
        vC.mMerchant = mMerchantGroup[indexPath.row].getMerchant()
        self.parentNavigationController?.pushViewController(vC, animated: true)
    }
    
    func  loadMore() {
        callWebservice()
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowMerchant" {
            let toVC : UIViewController = segue.destinationViewController
            toVC.transitioningDelegate = self;
        }
        super.prepareForSegue(segue, sender: sender)
    }
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        self.wirePopInteractionControllerTo(viewController)
    }
    
    func wirePopInteractionControllerTo(viewController : UIViewController) {
        
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if (self.navigationControllerAnimationController != nil) {
            self.navigationControllerAnimationController.reverse = operation == UINavigationControllerOperation.Pop
        }
        
        return self.navigationControllerAnimationController;
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
