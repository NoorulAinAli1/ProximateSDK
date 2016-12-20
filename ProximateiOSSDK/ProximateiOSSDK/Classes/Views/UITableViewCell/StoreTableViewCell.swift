//
//  StoreTableViewCell.swift
//  Pods
//
//  Created by NoorulAinAli on 20/12/2016.
//
//

import UIKit

class StoreTableViewCell: UITableViewCell {

    @IBOutlet var storeImage : UIImageView! {
        didSet {
            storeImage.image = ProximateSDKSettings.getImageForName("icon_location")
        }
    }
    
    @IBOutlet var storeTitle : BaseLabel! {
        didSet {
            storeTitle.setStyle(ProximateSDKSettings.psdkFontOptions.campaignDetailTextColor, size: ProximateSDKSettings.psdkFontOptions.campaignDetailTextSize)
        }
    }
    
    var mStore : ObjectStore! {
        didSet {
            updateView()
        }
    }
    
    private func updateView(){
        
        storeTitle.text = mStore.getTitle()
        
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
