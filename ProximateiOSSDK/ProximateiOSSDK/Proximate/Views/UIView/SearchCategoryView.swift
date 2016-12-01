//
//  SearchCategoryView.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 25/11/2016.
//  Copyright © 2016 ProximateiOSSDK. All rights reserved.
//

import UIKit


class SearchCategoryView: UIView {
    @IBOutlet var btnClose : UIButton!
    @IBOutlet var btnSearch : UIButton!
    @IBOutlet var searchBar : UITextField!
    
    override init(frame : CGRect){
        super.init(frame: frame)
        customize()
    }
    
//    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        // Custom initialization
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customize()
    }
    
    private func customize() {
        searchBar.placeholder = "hint_search".localized
    }

}
