//
//  PSDKLabel.swift
//  Pods
//
//  Created by NoorulAinAli on 08/12/2016.
//
//

import UIKit

public enum Styles {
    enum Labels {
        case Standard(CGFloat)
        case LargeText(CGFloat)
        
        func style(label: BaseLabel, color : UIColor) {
            switch self {
            case let .Standard(value):
                label.sdkFontSize = value
                label.textColor = color
            case let .LargeText(value):
//                label.font = UIFont.systemFontOfSize(value)
                label.textColor = color
            }
        }
    }
}

extension UIButton {
    var sdkFontName : String {
        get { return (self.titleLabel?.font.fontName)! }
        set { self.titleLabel?.font = UIFont(name: newValue, size: (self.titleLabel?.font.pointSize)!) }
    }
}

extension UITextField {
    var sdkFontName : String {
        get { return (self.font.fontName)! }
        set { self.font = UIFont(name: newValue, size: (self.font.pointSize)!) }
    }
}

