//
//  EmptyTableViewCell.swift
//  Pods
//
//  Created by NoorulAinAli on 22/12/2016.
//
//

import UIKit

class EmptyTableViewCell: UITableViewCell {
    @IBOutlet var mainView : CardView! {
        didSet {
            self.backgroundColor = UIColor.clearColor()
            self.contentView.backgroundColor = UIColor.clearColor()
        }
    }
    @IBOutlet var viewSpacing : [NSLayoutConstraint]!

    @IBOutlet var emptyImage : UIImageView! {
        didSet {
            emptyImage.image = ProximateSDKSettings.getImageForName("placeholder_campaign")
        }
    }
    
    @IBOutlet var emptyLabel : BaseLabel! {
        didSet {
            emptyLabel.setStyle(ProximateSDKSettings.psdkFontOptions.campaignDetailTextColor, size: ProximateSDKSettings.psdkFontOptions.campaignDetailTextSize)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    private func setOuterSpacing() {
        
        for item in self.viewSpacing {
            item.constant = ProximateSDKSettings.psdkViewOptions.outerPadding
        }
    }
    
    func setEmptyText(str : String) {
        emptyLabel.setFromString(str, setTextAlignment: .Center)
        setOuterSpacing()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
