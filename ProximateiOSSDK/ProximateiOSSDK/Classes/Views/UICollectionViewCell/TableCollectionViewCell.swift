//
//  TableCollectionViewCell.swift
//  Pods
//
//  Created by NoorulAinAli on 28/12/2016.
//
//

import UIKit

class TableCollectionViewCell: UICollectionViewCell {
   
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.customize()
    }
    
    override func awakeFromNib() {
        self.customize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.customize()
    }
    
    func customize(){
        
    }
}
