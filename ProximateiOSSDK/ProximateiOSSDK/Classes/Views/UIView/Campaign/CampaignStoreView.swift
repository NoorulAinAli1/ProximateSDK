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

class CampaignStoreView: CardView, UITableViewDelegate, UITableViewDataSource {
    private let innerPadding : CGFloat  = ProximateSDKSettings.psdkViewOptions.innerPadding
    let rowHeight : CGFloat  = 30
    let reuseCellIdentifier: String = "campaignCell"

    private var contentHeight : CGFloat  = 0.0

    var campaignStoreTitle : BaseLabel!

    var campaignStoreTable : BaseTableView!
    private var campaignStore : [ObjectStore]!
    var storeDelegate : CampaignStoreDelegate?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    init(frame : CGRect, campaignStore cStore : [ObjectStore]){
        super.init(frame: frame)
        
        let outerPadding : CGFloat  = ProximateSDKSettings.psdkViewOptions.outerPadding
        
        let viewWidth = self.frame.width/600 * UIScreen.mainScreen().bounds.size.width - (outerPadding * 3)
        campaignStoreTitle = BaseLabel(frame: CGRectMake(innerPadding, innerPadding, viewWidth - (innerPadding*2), ProximateSDKSettings.psdkFontOptions.campaignDetailTitleSize))
        campaignStoreTitle.backgroundColor = UIColor.clearColor()
        campaignStoreTitle.text = "psdk_title_stores".localized
        campaignStoreTitle.isBold = true
        campaignStoreTitle.setStyle(ProximateSDKSettings.psdkFontOptions.campaignDetailTitleColor, size: ProximateSDKSettings.psdkFontOptions.campaignDetailTitleSize)
        self.addSubview(campaignStoreTitle)
        
        campaignStoreTable = BaseTableView(frame: CGRectMake(innerPadding, ProximateSDKSettings.psdkFontOptions.campaignDetailTitleSize + innerPadding + innerPadding, viewWidth - (innerPadding*2), rowHeight * CGFloat(cStore.count)))
        campaignStoreTable.allowsSelection = true
        self.addSubview(campaignStoreTable)
        campaignStoreTable.delegate = self
        campaignStoreTable.dataSource = self
        
        self.campaignStoreTable.registerNib(UINib(nibName:"StoreTableViewCell", bundle:ProximateSDKSettings.getBundle()), forCellReuseIdentifier: reuseCellIdentifier)

        self.campaignStore = cStore

        contentHeight =  ProximateSDKSettings.psdkFontOptions.campaignDetailTitleSize  + innerPadding*3 + (rowHeight * CGFloat(campaignStore.count))
    }
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return campaignStore.count
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return rowHeight
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return rowHeight
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier(reuseCellIdentifier, forIndexPath: indexPath) as! StoreTableViewCell
        cell.mStore = self.campaignStore[indexPath.row]
        return cell
    }
    
    func getContentHeight() -> CGFloat {
        return contentHeight
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        storeDelegate?.didClickCampaignStore(self.campaignStore[indexPath.row])
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
    }

}
