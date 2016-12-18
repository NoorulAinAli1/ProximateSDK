//
//  ProximateSDKSettings.swift
//  Pods
//
//  Created by NoorulAinAli on 08/12/2016.
//
//

import UIKit

public enum PSDKTabOption {
    case ViewBackgroundColor(UIColor)
    case MenuMarginX(CGFloat)
    case MenuMarginY(CGFloat)
    case MenuHeight(CGFloat)
    case SelectedMenuItemLabelColor(UIColor)
    case UnselectedMenuItemLabelColor(UIColor)
    case SelectedMenuColor(UIColor)
    case UnselectedMenuColor(UIColor)
    case MenuItemSelectedBorderColor(UIColor)
    case MenuItemUnselectedBorderColor(UIColor)
    case MenuItemBorderWidth(CGFloat)
    case MenuItemFontSize(CGFloat)
    case EnableHorizontalBounce(Bool)
    case MenuItemWidthBasedOnTitleTextWidth(Bool)
    case ScrollAnimationDurationOnMenuItemTap(Int)
}

public enum PSDKFontStyleOptions {
    case SeeAllFontStyle(UIColor, CGFloat)
    case MerchantTitleFontStyle(UIColor, CGFloat)
    case ExpiryTextFontStyle(UIColor, UIColor, CGFloat)
    case MerchantTaglineFontStyle(UIColor, CGFloat)
    case CampaignTitleFontStyle(UIColor, UIColor, CGFloat)
    case CampaignDetailFontStyle(UIColor, CGFloat, UIColor, CGFloat)
    
}

struct FontStyleOptions {
    var seeAllFontColor     : UIColor!  = UIColor.blackColor()
    var seeAllFontSize      : CGFloat!  = 10.0
    var merchantTitleFontColor      : UIColor!  = UIColor.blackColor()
    var merchantTitleFontSize       : CGFloat!  = 16.0
    var merchantTaglineFontColor    : UIColor!  = UIColor.blackColor()
    var merchantTaglineFontSize     : CGFloat!  = 12.0
    var expiryTextFontColor         : UIColor!  = UIColor.blackColor()
    var expiredFontColor            : UIColor!  = UIColor.lightGrayColor()
    var expiryTextFontSize          : CGFloat!  = 12.0
    var campaignTextFontColor       : UIColor!  = UIColor.grayColor()
    var campaignBoldFontColor       : UIColor!  = UIColor.psdkPrimaryColor()
    var campaignTextFontSize        : CGFloat!  = 16.0
    var campaignDetailTitleSize     : CGFloat!  = 16.0
    var campaignDetailTextSize      : CGFloat!  = 12.0
    var campaignDetailTitleColor    : UIColor!  =  UIColor.blueColor()
    var campaignDetailTextColor     : UIColor!  =  UIColor.orangeColor()
    
    init(){
    }
    
    init(fontOptions: [PSDKFontStyleOptions]){
        for option in fontOptions {
            switch (option) {
            case let .SeeAllFontStyle(valueColor, valueSize):
                self.seeAllFontColor    = valueColor
                self.seeAllFontSize     = valueSize
            case let .MerchantTitleFontStyle(valueColor, valueSize):
                self.merchantTitleFontColor    = valueColor
                self.merchantTitleFontSize     = valueSize
            case let .MerchantTaglineFontStyle(valueColor, valueSize):
                self.merchantTaglineFontColor    = valueColor
                self.merchantTaglineFontSize     = valueSize
            case let .ExpiryTextFontStyle(valueColor, valueColor2, valueSize):
                self.expiryTextFontColor    = valueColor
                self.expiredFontColor       = valueColor2
                self.expiryTextFontSize     = valueSize
            case let .CampaignTitleFontStyle(valueColor, valueColor2, valueSize):
                self.campaignTextFontColor    = valueColor
                self.campaignBoldFontColor    = valueColor2
                self.campaignTextFontSize     = valueSize
            case let .CampaignDetailFontStyle(valueColor1, valueSize1, valueColor2, valueSize2):
                if valueSize1 <= valueSize2 {
                    assertionFailure("CampaignDetailTitleSize should be greater than CampaignDetailTextSize")
                }
                self.campaignDetailTitleSize    = valueSize1
                self.campaignDetailTextSize     = valueSize2
                self.campaignDetailTitleColor   = valueColor1
                self.campaignDetailTextColor    = valueColor2
  
            default: break
            }
        }
    }
}

public enum PSDKPageIndicatorOptions {
    case PageIndicatorColor(UIColor, UIColor)
    case PageIndicatorDiameter(CGFloat)
    case PageIndicatorSpace(CGFloat)
}

struct PageIndicatorOptions {
    var pageIndicatorSelectedColor    : UIColor!  = UIColor.purpleColor()
    var pageIndicatorUnselectedColor  : UIColor!  = UIColor.brownColor()
    var pageIndicatorDiameter  : CGFloat!  = 4.0
    var pageIndicatorSpace  : CGFloat!  = 4.0
    
    init(){
    }
    
    init(pageIndicatorOptions: [PSDKPageIndicatorOptions]){
        for option in pageIndicatorOptions {
            switch (option) {
            case let .PageIndicatorColor(valueSelected, valueUnselected):
                self.pageIndicatorSelectedColor = valueSelected
                self.pageIndicatorUnselectedColor = valueUnselected
            case let .PageIndicatorDiameter(value):
                self.pageIndicatorDiameter = value
            case let .PageIndicatorSpace(value):
                self.pageIndicatorSpace = value
            default: break
            }
        }
    }
}

public enum PSDKViewOptions {
    case PrimaryColor(UIColor)
    case ViewBackgroundColor(UIColor)
    case NavigationBarTitle(UIColor, CGFloat)
    case NavigationBarTintColor(UIColor)
    case SearchBar(UIColor)
    case Font(String, String)
}

struct ViewOptions {
    var primaryColor : UIColor! = UIColor.psdkPrimaryColor()
    var viewBackgroundColor : UIColor! = UIColor.grayColor()
    var navigationBarTintColor  : UIColor! = UIColor.grayColor()
    var navigationBarTitleSize  : CGFloat! = 16.0
    var navigationBarTitleColor  : UIColor! = UIColor.whiteColor()
    var searchBarColor     : UIColor!  = UIColor.brownColor()
    var fontRegular   : String! = "Futura"
    var fontBold   : String! = "Futura-CondensedExtraBold"
    
    init(){
    }
    
    init(viewOptions: [PSDKViewOptions]){
        for option in viewOptions {
            switch (option) {
            case let .PrimaryColor(value):
                self.primaryColor = value
            case let .ViewBackgroundColor(value):
                self.viewBackgroundColor = value
            case let .NavigationBarTitle(valueColor, valueSize):
                self.navigationBarTitleColor = valueColor
                self.navigationBarTitleSize = valueSize
            case let .NavigationBarTintColor(value):
                self.navigationBarTintColor = value
            case let .SearchBar(valueColor):
                self.searchBarColor = valueColor
            case let .Font(valueRegular, valueBold):
                self.fontRegular = valueRegular
                self.fontBold = valueBold
            default: break
            }
        }
    }
}

public enum PSDKCardOptions {
    case CardBackgroundColor(UIColor)
    case CardShadowColor(UIColor)
    case CardShadowOffset(CGSize)
    case CardBorderWidth(CGFloat)
    case CardBorderColor(UIColor)
    case CardCornerRadius(CGFloat)
    case CardShadowRadius(CGFloat)
    case CardShadowOpacity(Float)
}

struct CardOptions {
    var cardBackgroundColor : UIColor! = UIColor.whiteColor()
    var cardShadowColor     : UIColor! = UIColor.grayColor()
    var cardShadowOffset    : CGSize!  = CGSizeMake(0, 2)
    var cardBorderWidth     : CGFloat! = 1.0
    var cardBorderColor     : UIColor! = UIColor.clearColor()
    var cardCornerRadius    : CGFloat! = 4.0
    var cardShadowRadius    : CGFloat! = 4.0
    var cardShadowOpacity   : Float = 2.0
    
    init(){
    }
    
    init(cardOptions: [PSDKCardOptions]){
        for option in cardOptions {
            switch (option) {
            case let .CardBackgroundColor(value):
                self.cardBackgroundColor = value
            case let .CardShadowColor(value):
                self.cardShadowColor = value
            case let .CardShadowOffset(value):
                self.cardShadowOffset = value
            case let .CardBorderWidth(value):
                self.cardBorderWidth = value
            case let .CardBorderColor(value):
                self.cardBorderColor = value
            case let .CardCornerRadius(value):
                self.cardCornerRadius = value
            case let .CardShadowRadius(value):
                self.cardShadowRadius = value
            case let .CardShadowOpacity(value):
                self.cardShadowOpacity = value
            default: break
            }
        }
    
    }
}

public class ProximateSDKSettings: NSObject {
    private static var psdkViewOptions : ViewOptions! = ViewOptions() {
        didSet {
            initializeFonts()
        }
    }
    private static var psdkCardOptions : CardOptions! = CardOptions()
    private static var psdkPageIndicatorOptions : PageIndicatorOptions! = PageIndicatorOptions()
    private static var psdkFontOptions : FontStyleOptions! = FontStyleOptions()
    internal static var psdkTabOptions : [PSDKTabOption]!
    
    internal static func configure() {
        OCMapperConfig.configure()
        
    }
   
    private static func initializeFonts() {
        
        BaseButton.appearance().sdkFontName = self.psdkViewOptions.fontRegular
        UITextField.appearance().sdkFontName = self.psdkViewOptions.fontRegular

        UISegmentedControl.appearance().tintColor = ProximateSDKSettings.getViewOptions().primaryColor
        
        UISegmentedControl.appearance().setTitleTextAttributes([
                                                  NSFontAttributeName : UIFont(name: ProximateSDKSettings.getViewOptions().fontRegular, size: 16.0)!], forState: UIControlState.Normal)

        //        UISegmentedControl.appearance().backgroundColor = UIColor.cyanColor()

//        UILabel.appearance().sdkFontName = "Futura"
//        UILabel.appearance().sdkBoldFontName = "Futura-CondensedExtraBold"
    }
    
    public static func setTabStyleOptions(options: [PSDKTabOption])  {
        psdkTabOptions = options
    }
    
    
    public static func setFontStyleOptions(options: [PSDKFontStyleOptions])  {
        psdkFontOptions = FontStyleOptions(fontOptions: options)
    }
    
    internal static func getFontStyleOptions() -> FontStyleOptions  {
        return psdkFontOptions
    }
    
    public static func setPageIndicatorOptions(options: [PSDKPageIndicatorOptions])  {
        psdkPageIndicatorOptions = PageIndicatorOptions(pageIndicatorOptions: options)
    }
    
    internal static func getPageIndicatorOptions() -> PageIndicatorOptions  {
        return psdkPageIndicatorOptions
    }
    
    public static func setViewOptions(options: [PSDKViewOptions])  {
        psdkViewOptions = ViewOptions(viewOptions: options)
    }
    
    internal static func getViewOptions() -> ViewOptions  {
        return psdkViewOptions
    }
    
    public static func setCardOptions(cardOptions: [PSDKCardOptions]) {
        psdkCardOptions = CardOptions(cardOptions: cardOptions)
    }

    internal static func getCardOptions() -> CardOptions {
        return psdkCardOptions
    }

    internal static func getBundle() -> NSBundle {
        let podBundle = NSBundle(forClass: self.classForCoder())
        let bundleURL = podBundle.URLForResource("ProximateiOSSDK", withExtension: "bundle")
        guard let bundle = NSBundle(URL: bundleURL!) else {
            assertionFailure("Couldn't load ProximateiOSSDK bundle")
            return NSBundle.mainBundle()
        }
        //            assertionFailure("Could not create a path to the bundle")
        return bundle
    }
    
//    internal static func getLocalizedString() ->  [String] {
//        let stringsPath = NSBundle.mainBundle().pathForResource("Localizable", ofType: "strings")
//        let locStringsDict = NSDictionary(contentsOfFile: stringsPath!)
//        
//        DebugLogger.debugLog("locStringsDict = \(locStringsDict)");
//        let localizaedString = locStringsDict?.allKeys as! [String]
//        return localizaedString
//    }
    
    internal static func getImageForName(name : String) -> UIImage {
        guard let appImage = UIImage(named: name, inBundle: NSBundle.mainBundle(), compatibleWithTraitCollection: nil) else {
           return UIImage(named: name, inBundle: ProximateSDKSettings.getBundle(), compatibleWithTraitCollection: nil)!
        }

        return appImage
    }
    
    internal static func getCampaignPlaceholderImage() -> UIImage {
        return ProximateSDKSettings.getImageForName("placeholder_campaign")
    }
    
    internal static func getLoadingPlaceholderImage() -> UIImage {
        return ProximateSDKSettings.getImageForName("placeholder_loading")
    }
}
