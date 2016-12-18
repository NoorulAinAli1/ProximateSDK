//
//  BaseLabel.swift
//  Pods
//
//  Created by NoorulAinAli on 08/12/2016.
//
//

import UIKit

@IBDesignable
class BaseLabel: UILabel {
    
    @IBInspectable var isBold : Bool = false {
       didSet { customize() }
    }

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
    
    private func customize(){
        let fontName = isBold.boolValue ? ProximateSDKSettings.getBoldFontName() : ProximateSDKSettings.getFontName()
        
        self.font = UIFont(name: fontName, size: self.font.pointSize)
    }

    func style(style: Styles.Labels, color : UIColor) {
        style.style(self, color: color)
    }
    
    
    func setHTMLFromString(text: String, singleLine isSingleLine : Bool = true) {
        let modifiedFont = NSString(format:"<style>b {color: #ae6b0f; font-family: \(ProximateSDKSettings.getBoldFontName());}</style><span style=\"font-family: \(self.font!.fontName); font-size: \(self.font!.pointSize)\">%@</span>", text) as String
        
        //        let attrStr = try! NSAttributedString(
        //            data: modifiedFont.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!,
        //            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding],
        //            documentAttributes: nil)
        let attrStr = try! NSMutableAttributedString(
            data: modifiedFont.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!,
            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding],
            documentAttributes: nil)
        if isSingleLine {
            let style = NSMutableParagraphStyle()
            style.lineBreakMode = .ByTruncatingTail
            attrStr.addAttributes([ NSParagraphStyleAttributeName: style ],
                                  range: NSMakeRange(0, attrStr.length))
        }
        //        self.text = text
        self.attributedText = attrStr
    }
    
//    var sdkFontName : String {
//        get { return self.font.fontName }
//        set { self.font = UIFont(name: newValue, size: self.font.pointSize) }
//    }
//    
//    var sdkBoldFontName : String {
//        get { return self.font.fontName }
//        set {
//            DebugLogger.debugLog("fontNam \(self.font.fontName)")
//            if self.font.fontName.rangeOfString("Bold") != nil {
//                self.font = UIFont(name: newValue, size: self.font.pointSize)
//            }
//        }
//    }
    
    var sdkFontSize : CGFloat {
        get { return self.font.pointSize }
        set { self.font = UIFont(name: self.font!.fontName, size: newValue) }
    }
    
}
