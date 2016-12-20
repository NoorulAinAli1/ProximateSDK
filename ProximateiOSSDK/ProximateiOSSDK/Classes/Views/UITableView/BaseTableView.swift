//
//  BaseTableView.swift
//  Pods
//
//  Created by NoorulAinAli on 20/12/2016.
//
//

import UIKit

class BaseTableView: UITableView {

    override init(frame:CGRect, style: UITableViewStyle) {
        super.init(frame:frame, style: style)
        self.customize()
    }
    
    override func awakeFromNib() {
        self.customize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.customize()
    }
    
    internal func customize(){
        self.bounces = false
        self.separatorStyle = .None
        self.allowsSelection = false
        self.backgroundColor = UIColor.clearColor()
        

    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }

}