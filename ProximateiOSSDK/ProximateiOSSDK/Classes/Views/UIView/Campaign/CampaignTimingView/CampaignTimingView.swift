//
//  CampaignTimingView.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 05/12/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit

class CampaignTimingView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var campaignTimingTitle : UILabel!
    @IBOutlet var campaignTimingTable : UITableView!
    private var campaignTiming : [ObjectCampaignTiming]!
    private let currentDay  = DateTimeUtility.getCurrentDay()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCampaignTiming(campaignTiming cTiming : [ObjectCampaignTiming]) {
        self.borderAndShadow()
        
        self.campaignTimingTable.registerClass(UITableViewCell.self, forCellReuseIdentifier:"cell")

        self.campaignTiming = cTiming
//        self.campaignTimingTable.rowHeight = UITableViewAutomaticDimension
//        self.campaignTimingTable.estimatedRowHeight =  20//self.view.frame.height * 0.5

    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return campaignTiming.count
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30
    }
    //    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    //        return 200
    //    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let reuseIdentifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) //as! UITableViewCell
        cell = UITableViewCell(style: UITableViewCellStyle.Value1,
                                   reuseIdentifier: reuseIdentifier)
        
        let timing = self.campaignTiming[indexPath.row]
        cell.textLabel?.text = timing.getDay()
        cell.detailTextLabel?.text = timing.getTiming()
        cell.imageView?.image = UIImage(named: "icon_timing", inBundle: ProximateSDK.getBundle(), compatibleWithTraitCollection: nil)!

        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.lineBreakMode = .ByWordWrapping
        if (timing.getDay() == currentDay){
            cell.textLabel?.textColor = UIColor.psdkPrimaryColor()
            cell.detailTextLabel?.textColor = UIColor.psdkPrimaryColor()
            cell.imageView?.image = cell.imageView?.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            cell.imageView?.tintColor = UIColor.psdkPrimaryColor()
        }
        
        return cell
    }
    
}
