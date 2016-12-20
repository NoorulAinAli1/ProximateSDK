//
//  CampaignTimingView.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 05/12/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit

class CampaignTimingView: CardView, UITableViewDelegate, UITableViewDataSource {
    private let innerPadding : CGFloat  = ProximateSDKSettings.psdkViewOptions.innerPadding
    var rowHeight : CGFloat  = 30
    let reuseIdentifier = "cell"

    private var contentHeight : CGFloat  = 0.0
    private var singleLine = true
    var campaignTimingTitle : BaseLabel!

    var campaignTimingTable : BaseTableView!
    private var campaignTiming : [ObjectCampaignTiming]!
    private let currentDay  = DateTimeUtility.getCurrentDay()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    init(frame : CGRect, campaignTiming cTiming : [ObjectCampaignTiming]){
        super.init(frame: frame)
        
        let outerPadding : CGFloat  = ProximateSDKSettings.psdkViewOptions.outerPadding
        
        let viewWidth = self.frame.width/600 * UIScreen.mainScreen().bounds.size.width - (outerPadding * 2.5)
        campaignTimingTitle = BaseLabel(frame: CGRectMake(innerPadding, innerPadding, viewWidth - (innerPadding*2), ProximateSDKSettings.psdkFontOptions.campaignDetailTitleSize))
        campaignTimingTitle.backgroundColor = UIColor.clearColor()
        campaignTimingTitle.setStyle(ProximateSDKSettings.psdkFontOptions.campaignDetailTitleColor, size: ProximateSDKSettings.psdkFontOptions.campaignDetailTitleSize)
        campaignTimingTitle.text = "psdk_title_timings".localized
        campaignTimingTitle.isBold = true
        self.addSubview(campaignTimingTitle)
        
        singleLine = cTiming[0].getIsSingleLine()
        rowHeight *= singleLine ? 1 : 1.8
        
        campaignTimingTable = BaseTableView(frame: CGRectMake(innerPadding, ProximateSDKSettings.psdkFontOptions.campaignDetailTitleSize + innerPadding + innerPadding, viewWidth - (innerPadding*2), rowHeight * CGFloat(cTiming.count)))

        self.addSubview(campaignTimingTable)
        campaignTimingTable.delegate = self
        campaignTimingTable.dataSource = self
        
        self.campaignTimingTable.registerNib(UINib(nibName:"CampaignTimingTableViewCell", bundle:ProximateSDKSettings.getBundle()), forCellReuseIdentifier: reuseIdentifier)
        self.campaignTiming = cTiming

        contentHeight =  ProximateSDKSettings.psdkFontOptions.campaignDetailTitleSize  + innerPadding*3 + (rowHeight * CGFloat(campaignTiming.count))
        
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return campaignTiming.count
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return rowHeight
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CampaignTimingTableViewCell
        
        cell.mTiming = self.campaignTiming[indexPath.row]
        cell.timingInfoHeight.constant = rowHeight * 0.8
        if (cell.mTiming.getDay() == currentDay){
            cell.setCurrentDay()
        }
        
        return cell
    }
    
    func getContentHeight() -> CGFloat {
        return contentHeight
    }
    
}
