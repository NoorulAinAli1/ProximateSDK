//
//  CardView.swift
//  Pods
//
//  Created by NoorulAinAli on 08/12/2016.
//
//

import UIKit

class CardView: UIView {
    private var cardBackgroundColor : UIColor! = UIColor.whiteColor()
    private var cardShadowColor     : UIColor! = UIColor.grayColor()
    private var cardShadowOffset    : CGSize!  = CGSizeMake(0, 2)
    private var cardBorderWidth     : CGFloat! = 1.0
    private var cardBorderColor     : UIColor! = UIColor.clearColor()
    private var cardCornerRadius    : CGFloat! = 4.0
    private var cardShadowRadius    : CGFloat! = 4.0
    private var cardShadowOpacity   : Float! = 2.0
    
    var cardOptions: CardOptions?
    
    override init(frame : CGRect){
        super.init(frame: frame)
        cardOptions = ProximateSDKSettings.psdkCardOptions

        loadCardOptions()
    }
    
    init(frame: CGRect, options: [String: AnyObject]?) {
        super.init(frame: frame)
        loadCardOptions()
    }
    
    convenience init(frame: CGRect, cardOptions: CardOptions) {
        self.init(frame:frame, options:nil)
        
        self.cardOptions = cardOptions
        loadCardOptions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardOptions = ProximateSDKSettings.psdkCardOptions
        loadCardOptions()
    }
    
    private func loadCardOptions(){
    
        cardBackgroundColor = cardOptions?.cardBackgroundColor
        cardShadowColor = cardOptions?.cardShadowColor
        cardShadowOffset = cardOptions?.cardShadowOffset
        cardBorderWidth = cardOptions?.cardBorderWidth
        cardBorderColor = cardOptions?.cardBorderColor
        cardCornerRadius = cardOptions?.cardCornerRadius
        cardShadowRadius = cardOptions?.cardShadowRadius
        cardShadowOpacity = cardOptions?.cardShadowOpacity

        customize()
    }
    
    private func customize() {
        self.userInteractionEnabled = true
        
        self.layer.masksToBounds = false
        self.backgroundColor = cardBackgroundColor
        self.layer.borderWidth = cardBorderWidth
        self.layer.borderColor = cardBorderColor.CGColor
        self.layer.cornerRadius = cardCornerRadius
        
        self.layer.shadowColor = cardShadowColor.CGColor
        self.layer.shadowOffset = cardShadowOffset
        self.layer.shadowRadius = cardCornerRadius
        self.layer.shadowOpacity = cardShadowOpacity
    }

}
