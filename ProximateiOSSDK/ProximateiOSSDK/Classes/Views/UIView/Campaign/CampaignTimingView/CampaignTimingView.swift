//
//  CampaignTimingView.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 05/12/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit

class CampaignTimingView: CardView, UITableViewDelegate, UITableViewDataSource {
    private var innerPadding : CGFloat  = 0.0
    let rowHeight : CGFloat  = 30.0
    
    private var contentHeight : CGFloat  = 0.0

    var campaignTimingTitle : BaseLabel!

    var campaignTimingTable : UITableView!
    private var campaignTiming : [ObjectCampaignTiming]!
    private let currentDay  = DateTimeUtility.getCurrentDay()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    init(frame : CGRect, campaignTiming cTiming : [ObjectCampaignTiming], withInnerPadding iPadding : CGFloat){
        super.init(frame: frame)
        innerPadding = iPadding
        let viewWidth = frame.width/600 * UIScreen.mainScreen().bounds.size.width
        campaignTimingTitle = BaseLabel(frame: CGRectMake(innerPadding, innerPadding, viewWidth - (innerPadding*2), ProximateSDKSettings.getFontStyleOptions().campaignDetailTitleSize))
        campaignTimingTitle.backgroundColor = UIColor.cyanColor()
        campaignTimingTitle.setStyle(ProximateSDKSettings.getFontStyleOptions().campaignDetailTitleColor, size: ProximateSDKSettings.getFontStyleOptions().campaignDetailTitleSize)
        campaignTimingTitle.text = "psdk_title_timings".localized
        campaignTimingTitle.isBold = true
        self.addSubview(campaignTimingTitle)
        
        
        campaignTimingTable = UITableView(frame: CGRectMake(innerPadding, ProximateSDKSettings.getFontStyleOptions().campaignDetailTitleSize + innerPadding + innerPadding, viewWidth - (innerPadding*2), rowHeight * CGFloat(cTiming.count)))
        self.campaignTiming = cTiming

        campaignTimingTable.backgroundColor = UIColor.darkGrayColor()
        self.addSubview(campaignTimingTable)
        campaignTimingTable.delegate = self
        campaignTimingTable.dataSource = self
        

        self.campaignTimingTable.registerClass(UITableViewCell.self, forCellReuseIdentifier:"cell")
        self.campaignTimingTable.reloadData()
        
        contentHeight =  ProximateSDKSettings.getFontStyleOptions().campaignDetailTitleSize  + innerPadding*3 + (rowHeight * CGFloat(campaignTiming.count))
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

        let reuseIdentifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) //as! UITableViewCell
        cell = UITableViewCell(style: UITableViewCellStyle.Value1,
                                   reuseIdentifier: reuseIdentifier)
        
        let timing = self.campaignTiming[indexPath.row]
        cell.textLabel?.text = timing.getDay()
        cell.detailTextLabel?.text = timing.getTiming()
        cell.backgroundColor = UIColor.brownColor()
        cell.textLabel?.setStyle(ProximateSDKSettings.getFontStyleOptions().campaignDetailTextColor, size: ProximateSDKSettings.getFontStyleOptions().campaignDetailTextSize)
        cell.textLabel?.font = UIFont(name: ProximateSDKSettings.getViewOptions().fontRegular, size: (cell.textLabel?.font.pointSize)!)
        cell.detailTextLabel?.setStyle(ProximateSDKSettings.getFontStyleOptions().campaignDetailTextColor, size: ProximateSDKSettings.getFontStyleOptions().campaignDetailTextSize)
        cell.detailTextLabel?.font = UIFont(name: ProximateSDKSettings.getViewOptions().fontRegular, size: (cell.textLabel?.font.pointSize)!)

        cell.imageView?.image = ProximateSDKSettings.getImageForName("icon_timing")

        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.lineBreakMode = .ByWordWrapping
        if (timing.getDay() == currentDay){
            cell.textLabel?.textColor = ProximateSDKSettings.getViewOptions().primaryColor
            cell.detailTextLabel?.textColor = ProximateSDKSettings.getViewOptions().primaryColor
            cell.imageView?.image = cell.imageView?.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            cell.imageView?.tintColor = ProximateSDKSettings.getViewOptions().primaryColor
        }
        
        return cell
    }
    
    func getContentHeight() -> CGFloat {
        return contentHeight
    }
    
}
