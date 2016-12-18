//
//  campaignBankView.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 05/12/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit

class CampaignBankView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var campaignBankTitle : BaseLabel!
    @IBOutlet var campaignBankTable : UITableView!
    private var campaignBank : [ObjectBank]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCampaignBank(campaignBank cBank : [ObjectBank]) {
        self.borderAndShadow()
        
//        self.campaignBankTable.registerClass(BankCardTableViewCell.self, forCellReuseIdentifier:"cell")

        self.campaignBankTable.registerNib(UINib(nibName:"BankCardTableViewCell", bundle:ProximateSDKSettings.getBundle()), forCellReuseIdentifier: "cell")
        
        self.campaignBank = cBank
        DebugLogger.debugLog("campaignBank \(campaignBank)")
        DebugLogger.debugLog("cabk \(cBank)")
        self.campaignBankTable.rowHeight = UITableViewAutomaticDimension
        self.campaignBankTable.estimatedRowHeight =  60//self.view.frame.height * 0.5

    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return campaignBank.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (campaignBank[section].cards?.count)!
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    //    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    //        return 200
    //    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let reuseIdentifier = "cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! BankCardTableViewCell

        let bank = self.campaignBank[indexPath.section]
        let bankCard = bank.cards![indexPath.row]
        
        cell.bankImage = bank.merchantLogoImagePath
        cell.bankCard = bankCard
        return cell
    }
}
