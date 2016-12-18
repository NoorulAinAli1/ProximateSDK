//
//  campaignBankView.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 05/12/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit

class CampaignBankView: CardView, UITableViewDelegate, UITableViewDataSource {
    private var innerPadding : CGFloat  = ProximateSDKSettings.psdkViewOptions.innerPadding
    let rowHeight : CGFloat  = 200.0
    
    private var contentHeight : CGFloat  = 0.0

    var campaignBankTitle : BaseLabel!

    var campaignBankTable : UITableView!
    private var campaignBank : [ObjectBank]!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    init(frame : CGRect, campaignBank cBank : [ObjectBank], withInnerPadding iPadding : CGFloat){
        super.init(frame: frame)
        innerPadding = iPadding
        let viewWidth = frame.width/600 * UIScreen.mainScreen().bounds.size.width
        
        campaignBankTitle = BaseLabel(frame: CGRectMake(innerPadding, innerPadding, viewWidth - (innerPadding*2), ProximateSDKSettings.psdkFontOptions.campaignDetailTitleSize))
        campaignBankTitle.backgroundColor = UIColor.cyanColor()
        campaignBankTitle.isBold = true
        campaignBankTitle.text = "psdk_title_deals_available_at".localized
        campaignBankTitle.setStyle(ProximateSDKSettings.psdkFontOptions.campaignDetailTitleColor, size: ProximateSDKSettings.psdkFontOptions.campaignDetailTitleSize)
        self.addSubview(campaignBankTitle)
        
        for bank in cBank {
            contentHeight += (rowHeight * CGFloat((bank.cards?.count)!))
        }
        campaignBankTable = UITableView(frame: CGRectMake(innerPadding, ProximateSDKSettings.psdkFontOptions.campaignDetailTitleSize + innerPadding + innerPadding, viewWidth - (innerPadding*2), contentHeight))
        
        campaignBankTable.backgroundColor = UIColor.darkGrayColor()
        self.addSubview(campaignBankTable)
        campaignBankTable.delegate = self
        campaignBankTable.dataSource = self
        
        self.campaignBankTable.registerNib(UINib(nibName:"BankCardTableViewCell", bundle:ProximateSDKSettings.getBundle()), forCellReuseIdentifier: "cell")
        
        self.campaignBank = cBank
        DebugLogger.debugLog("campaignBank \(campaignBank)")
        DebugLogger.debugLog("cabk \(cBank)")
//        self.campaignBankTable.rowHeight = UITableViewAutomaticDimension
//        self.campaignBankTable.estimatedRowHeight =  100//self.view.frame.height * 0.5

    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return campaignBank.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (campaignBank[section].cards?.count)!
    }
//    
//    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return rowHeight + rowHeight
//    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return rowHeight
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let reuseIdentifier = "cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! BankCardTableViewCell

        let bank = self.campaignBank[indexPath.section]
        let bankCard = bank.cards![indexPath.row]
        
//        cell.bankImage = bank.merchantLogoImagePath
        cell.bankCard = bankCard
        return cell
    }
    
    func getContentHeight() -> CGFloat {
        return ProximateSDKSettings.psdkFontOptions.campaignDetailTitleSize + innerPadding*3 + contentHeight
    }
    
}
