//
//  CategoryTableViewController.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 24/11/2016.
//  Copyright © 2016 ProximateiOSSDK. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController, SearchDelegate, CampaignInfoClickDelegate {
    var mCategory : ObjectCategory!
    var parentNavigationController : UINavigationController?

    private var pageNumber : NSInteger = 0
    private var mMerchantGroup : [ObjectMerchantGroup] = []
    private var searchString : String! = ""
    private var loadMoreAvailable: Bool = true
    private let storyBoard = UIStoryboard(name: "ProximateSDK", bundle: NSBundle.mainBundle())

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = mCategory.getCategoryTitle()

        self.refreshControl = UIRefreshControl()
        self.refreshControl!.tintColor = UIColor.psdkPrimaryColor()
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
        //                DebugLogger.print("campaigns \(campaigns)")
        pageNumber += 1
        
        mMerchantGroup.sortInPlace { $0.getSortOrder().compare($1.getSortOrder()) == .OrderedAscending }
        
        self.refreshControl!.endRefreshing()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        ProximateiOSSDK.getScreenInteractionDelegate()?.screenInteracted()
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
//        ProximateiOSSDK.getScreenInteractionDelegate()?.screenInteracted()
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let addLoadMoreRow = self.loadMoreAvailable && mMerchantGroup.count > 0 ? 1 : 0
        return mMerchantGroup.count + addLoadMoreRow
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return indexPath.row < mMerchantGroup.count ? 300 : 100
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        if indexPath.row < mMerchantGroup.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("MerchantCell", forIndexPath: indexPath) as! MerchantTableViewCell
            cell.setMerchantGroup(mMerchantGroup[indexPath.row])
            cell.delegate = self
            return cell
        } else {
            let cellnib  = NSBundle.mainBundle().loadNibNamed("LoadMoreTableViewCell", owner:self, options: nil)![0] as! LoadMoreTableViewCell
            loadMore()
    
            return cellnib
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

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
