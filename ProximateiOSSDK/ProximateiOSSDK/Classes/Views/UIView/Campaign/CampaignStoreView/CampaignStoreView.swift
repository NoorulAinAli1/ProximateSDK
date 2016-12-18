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
    private var innerPadding : CGFloat  = 0.0
    let rowHeight : CGFloat  = 30.0
    
    private var contentHeight : CGFloat  = 0.0

    var campaignStoreTitle : BaseLabel!

    var campaignStoreTable : UITableView!
    private var campaignStore : [ObjectStore]!
    var storeDelegate : CampaignStoreDelegate?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    init(frame : CGRect, campaignStore cStore : [ObjectStore], withInnerPadding iPadding : CGFloat){
        super.init(frame: frame)
        innerPadding = iPadding
        let viewWidth = frame.width/600 * UIScreen.mainScreen().bounds.size.width
        DebugLogger.debugLog("screenWidth \(viewWidth)")
        campaignStoreTitle = BaseLabel(frame: CGRectMake(innerPadding, innerPadding, viewWidth - (innerPadding*2), ProximateSDKSettings.getFontStyleOptions().campaignDetailTitleSize))
        campaignStoreTitle.backgroundColor = UIColor.cyanColor()
        campaignStoreTitle.text = "psdk_title_stores".localized
        campaignStoreTitle.isBold = true
        campaignStoreTitle.setStyle(ProximateSDKSettings.getFontStyleOptions().campaignDetailTitleColor, size: ProximateSDKSettings.getFontStyleOptions().campaignDetailTitleSize)
        self.addSubview(campaignStoreTitle)
        
        campaignStoreTable = UITableView(frame: CGRectMake(innerPadding, ProximateSDKSettings.getFontStyleOptions().campaignDetailTitleSize + innerPadding + innerPadding, viewWidth - (innerPadding*2), rowHeight * CGFloat(cStore.count)))
        campaignStoreTable.bounces = false
        campaignStoreTable.backgroundColor = UIColor.darkGrayColor()
        self.addSubview(campaignStoreTable)
        campaignStoreTable.delegate = self
        campaignStoreTable.dataSource = self
        
        self.campaignStoreTable.registerClass(UITableViewCell.self, forCellReuseIdentifier:"cell")

        self.campaignStore = cStore

        contentHeight =  ProximateSDKSettings.getFontStyleOptions().campaignDetailTitleSize  + innerPadding*3 + (rowHeight * CGFloat(campaignStore.count))
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

        let reuseIdentifier = "cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) //as! UITableViewCell
        cell.backgroundColor = UIColor.clearColor()
        let store = self.campaignStore[indexPath.row]
        cell.textLabel?.text = store.getTitle()
        cell.imageView?.image = ProximateSDKSettings.getImageForName("icon_location")
        cell.textLabel?.setStyle(ProximateSDKSettings.getFontStyleOptions().campaignDetailTextColor, size: ProximateSDKSettings.getFontStyleOptions().campaignDetailTextSize)
        cell.textLabel?.font = UIFont(name: ProximateSDKSettings.getViewOptions().fontRegular, size: (cell.textLabel?.font.pointSize)!)
        return cell
    }
    
    func getContentHeight() -> CGFloat {
        return contentHeight
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        storeDelegate?.didClickCampaignStore(self.campaignStore[indexPath.row])
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
    }

}
