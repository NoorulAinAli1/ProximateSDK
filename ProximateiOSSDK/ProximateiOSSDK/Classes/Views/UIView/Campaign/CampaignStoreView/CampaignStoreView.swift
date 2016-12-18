//
//  campaignStoreView.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 05/12/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit

@objc protocol CampaignStoreDelegate {
    func didClickCampaignStore(campaignStore : ObjectStore)
}

class CampaignStoreView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var campaignStoreTitle : BaseLabel!
    @IBOutlet var campaignStoreTable : UITableView!
    private var campaignStore : [ObjectStore]!
    var storeDelegate : CampaignStoreDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCampaignStore(campaignStore cStore : [ObjectStore]) {
        self.borderAndShadow()
        
        self.campaignStoreTable.registerClass(UITableViewCell.self, forCellReuseIdentifier:"cell")

        self.campaignStore = cStore

//        self.campaignStoreTable.rowHeight = UITableViewAutomaticDimension
//        self.campaignStoreTable.estimatedRowHeight =  20//self.view.frame.height * 0.5

    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return campaignStore.count
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30
    }
    //    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    //        return 200
    //    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let reuseIdentifier = "cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) //as! UITableViewCell
        
        let store = self.campaignStore[indexPath.row]
        cell.textLabel?.text = store.getTitle()
        cell.imageView?.image = ProximateSDKSettings.getImageForName("icon_location")
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        storeDelegate?.didClickCampaignStore(self.campaignStore[indexPath.row])
    }
}
