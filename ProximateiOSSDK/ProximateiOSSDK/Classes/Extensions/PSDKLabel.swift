//
//  PSDKLabel.swift
//  Pods
//
//  Created by NoorulAinAli on 08/12/2016.
//
//

import UIKit

internal extension UILabel {
    var sdkFontSize : CGFloat {
        get { return self.font.pointSize }
        set { self.font = UIFont(name: self.font!.fontName, size: newValue) }
    }
    
    func setStyle(textColor : UIColor, size fontSize: CGFloat){
        self.textColor = textColor
        self.sdkFontSize = fontSize
    }
    
    
    func heightForText(text: String, maxWidth: CGFloat) -> CGFloat {
        let attrString = NSAttributedString.init(string: text, attributes: [NSFontAttributeName:self.font])
        let rect = attrString.boundingRectWithSize(CGSize(width: maxWidth, height: 10000), options: [NSStringDrawingOptions.UsesLineFragmentOrigin, NSStringDrawingOptions.UsesFontLeading], context: nil)
        //        let size = CGSizeMake(rect.size.width, rect.size.height)
        //        return size
        

        return rect.size.height
    }
}

internal extension UIButton {
    var sdkFontName : String {
        get { return (self.titleLabel!.font.fontName) }
        set { self.titleLabel!.font = UIFont(name: newValue, size: self.titleLabel!.font.pointSize) }
    }
}

internal extension UITextField {
    var sdkFontName : String {
        get { return (self.font!.fontName) }
        set { self.font = UIFont(name: newValue, size: self.font!.pointSize) }
    }
}

