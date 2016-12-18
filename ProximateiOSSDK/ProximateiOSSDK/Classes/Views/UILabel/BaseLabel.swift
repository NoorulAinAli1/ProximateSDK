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
        let fontName = isBold.boolValue ? ProximateSDKSettings.psdkViewOptions.fontBold : ProximateSDKSettings.psdkViewOptions.fontRegular
        self.font = UIFont(name: fontName, size: self.font.pointSize)
    }
    
//    func setStyle(textColor : UIColor, size fontSize: CGFloat){
//        self.textColor = textColor
//        self.sdkFontSize = fontSize
//    }

    func hexStringFromColor (color : UIColor) -> NSString {
        let components = CGColorGetComponents(color.CGColor)
        
        let r : Float = Float(components[0])
        let g : Float = Float(components[1])
        let b : Float = Float(components[2])
        
        return NSString(format: "#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255));
    }
    
    func setHTMLFromString(text: String, singleLine isSingleLine : Bool = true) {
        let boldColor = hexStringFromColor(ProximateSDKSettings.psdkFontOptions.campaignBoldFontColor)
        let normalColor = hexStringFromColor(ProximateSDKSettings.psdkFontOptions.campaignTextFontColor)
//        let modifiedFont = NSString(format:"<style>b {color: \(boldColor); font-family: \(ProximateSDKSettings.psdkViewOptions.fontBold);}</style><span style=\"font-family: \(self.font!.fontName); color: \(normalColor); font-size: \(self.font!.pointSize)\">%@</span>", text) as String
        let modifiedFont = NSString(format:"<style>span {font-family: \(ProximateSDKSettings.psdkViewOptions.fontRegular); color: \(normalColor); font-size: \(self.font!.pointSize)}; b {color: \(boldColor); font-family: \(ProximateSDKSettings.psdkViewOptions.fontBold);}</style><span>%@</span>", text) as String
        
        let attrStr = try! NSMutableAttributedString(
            data: modifiedFont.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!,
            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding],
            documentAttributes: nil)
        let style = NSMutableParagraphStyle()
//        style.lineSpacing = 0.75
//        style.paragraphSpacing = 0.25 * self.font.lineHeight
        if isSingleLine {
            style.lineBreakMode = .ByTruncatingTail
        }
        attrStr.addAttributes([ NSParagraphStyleAttributeName: style ],
                              range: NSMakeRange(0, attrStr.length))

        //        self.text = text
        self.attributedText = attrStr
    }
    
//    var sdkFontName : String {
//        get { return self.font.fontName }
//        set { self.font = UIFont(name: newValue, size: self.font.pointSize) }
//    }
//    
    
//    var sdkFontSize : CGFloat {
//        get { return self.font.pointSize }
//        set { self.font = UIFont(name: self.font!.fontName, size: newValue) }
//    }
    
}
