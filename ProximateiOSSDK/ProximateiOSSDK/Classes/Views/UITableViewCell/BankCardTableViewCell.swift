//
//  BankCardTableViewCell.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 05/12/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit

class BankCardTableViewCell : UITableViewCell {
    
    @IBOutlet var bankCardImage : UIImageView!
    
    @IBOutlet var bankCardTitle : UILabel!
    @IBOutlet var bankCardTagline : UILabel!
    @IBOutlet var bankCardOfferText : UILabel!
    
    var bankCard : ObjectBankCard! {
        didSet {
            updateView()
        }
    }
    
    var bankImage : String = "" {
        didSet {
            updateBankImage()
        }
    }
    
    private func updateBankImage() {
        bankCardImage.af_setImageWithURL(NSURL(string: bankImage)!,  completion: nil)
        
    }
    
    private func updateView(){
        
        bankCardTitle.text = bankCard.cardTitle
        bankCardTagline.text = bankCard.tagLine ?? ""
        bankCardOfferText.text = bankCard.offerText ?? ""
        
    }
    
    override func drawRect(rect : CGRect) {
        super.drawRect(rect)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
