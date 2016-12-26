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
    case MenuMargin(CGFloat, CGFloat)
    case MenuHeight(CGFloat)
    case MenuItemLabelColor(UIColor, UIColor)
    case MenuItemBackgroundColor(UIColor,UIColor)
    case MenuItemBorderColor(UIColor, UIColor)
    case MenuItemBorderWidth(CGFloat)
    case MenuItemFontSize(CGFloat)
//    case EnableHorizontalBounce(Bool)
//    case MenuItemWidthBasedOnTitleTextWidth(Bool)
    case ScrollAnimationDurationOnMenuItemTap(Int)
}

struct TabStyleOptions {
    var menuHeight : CGFloat = 44.0
    var menuMarginX : CGFloat = 10.0
    var menuMarginY : CGFloat = 6.0
    var scrollAnimationDurationOnMenuItemTap : Int = 500 // Millisecons
    
    var selectedMenuItemLabelColor = UIColor.whiteColor()
    var unselectedMenuItemLabelColor : UIColor = UIColor.lightGrayColor()
    var selectedMenuColor : UIColor      = UIColor.psdkTabSelectedColor()
    var unselectedMenuColor : UIColor    = UIColor.psdkTabUnselectedColor()
    var viewBackgroundColor : UIColor    = UIColor.psdkTabViewBackgroundColor()
    var menuItemSelectedBorderColor : UIColor    = UIColor.psdkTabViewBackgroundColor()
    var menuItemUnselectedBorderColor : UIColor    = UIColor.psdkTabSelectedColor()
    var menuItemBorderWidth : CGFloat    = 1.0
    
    var menuItemFontSize : CGFloat = 15.0
    
//    var menuItemWidthBasedOnTitleTextWidth : Bool = true
//    var enableHorizontalBounce : Bool = false
    init(){
    }
    
    init(tabOptions: [PSDKTabOption]){
        for option in tabOptions {
            switch (option) {
            case let .ViewBackgroundColor(value):
                self.viewBackgroundColor = value
            case let .MenuHeight(value):
                self.menuHeight = value
            case let .MenuMargin(valueX, valueY):
                self.menuMarginX    = valueX
                self.menuMarginY    = valueY
            case let .MenuItemLabelColor(valueSelected, valueUnselected):
                self.selectedMenuItemLabelColor    = valueSelected
                self.unselectedMenuItemLabelColor  = valueUnselected
            case let .MenuItemBackgroundColor(valueSelected, valueUnselected):
                self.selectedMenuColor    = valueSelected
                self.unselectedMenuColor  = valueUnselected
            case let .MenuItemBorderColor(valueSelected, valueUnselected):
                self.menuItemSelectedBorderColor    = valueSelected
                self.menuItemUnselectedBorderColor  = valueUnselected
            case let .MenuItemBorderWidth(value):
                self.menuItemBorderWidth    = value
            case let .MenuItemFontSize(value):
                self.menuItemFontSize = value
            case let .ScrollAnimationDurationOnMenuItemTap(value):
                self.scrollAnimationDurationOnMenuItemTap = value
                
            default: break
            }
        }
    }
}

public enum PSDKFontStyleOptions {
    case SeeAllFontStyle(UIColor, CGFloat)
    case MerchantTitleFontStyle(UIColor, CGFloat)
    case ExpiryTextFontStyle(UIColor, UIColor, CGFloat)
    case MerchantTaglineFontStyle(UIColor, CGFloat)
    case CampaignTitleFontStyle(UIColor, UIColor, CGFloat)
    case CampaignDetailFontStyle(UIColor, CGFloat, UIColor, CGFloat)
    
}

public enum CampaignSectionSequence : Int {
    case Detail
    case Store
    case Timing
    case Bank
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
    var campaignDetailBankOfferColor : UIColor! = UIColor.orangeColor()
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
    case PrimaryColor(UIColor, UIColor)
    case ViewBackgroundColor(UIColor)
    case NavigationBarImage(String)
    case NavigationBarTitle(UIColor, CGFloat)
    case NavigationBarTintColor(UIColor)
    case SearchBar(UIColor)
    case Font(String, String)
    case Padding(CGFloat, CGFloat)
    case CardHeight(CGFloat)
    case HeaderHeight(CGFloat)
}

struct ViewOptions {
    var primaryColor : UIColor! = UIColor.psdkPrimaryColor()
    var primaryDarkColor : UIColor! = UIColor.psdkPrimaryDarkColor()
    var viewBackgroundColor : UIColor! = UIColor.grayColor()
    var navigationBarImage  : UIImage?
    var navigationBarTintColor  : UIColor! = UIColor.whiteColor()
    var navigationBarTitleSize  : CGFloat! = 16.0
    var navigationBarTitleColor  : UIColor! = UIColor.whiteColor()
    var searchBarColor     : UIColor!  = UIColor.brownColor()
    var fontRegular   : String! = "TrebuchetMS" {
        didSet {
            if UIFont(name: fontRegular, size: 10) == nil {
                fontRegular = "TrebuchetMS"
            }
        }
    }
    var fontBold   : String! = "TrebuchetMS-Bold" {
        didSet {
            if UIFont(name: fontBold, size: 10) == nil {
                fontBold = "TrebuchetMS-Bold"
            }
        }
    }

    var innerPadding  : CGFloat! = 6.0
    var outerPadding  : CGFloat! = 10.0
    var cardHeight  : CGFloat! = 200.0
    var headerHeight  : CGFloat! = 300.0

    init(){
    }
    
    init(viewOptions: [PSDKViewOptions]){
        for option in viewOptions {
            switch (option) {
            case let .PrimaryColor(value, valueDark):
                self.primaryColor = value
                self.primaryDarkColor = valueDark
            case let .ViewBackgroundColor(value):
                self.viewBackgroundColor = value
            case let .NavigationBarImage(value):
                self.navigationBarImage = ProximateSDKSettings.getImageForName(value)
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
            case let .Padding(valueInner, valueOuter):
                self.innerPadding = valueInner
                self.outerPadding = valueOuter
            case let .CardHeight(value):
                self.cardHeight = value
            case let .HeaderHeight(value):
                self.headerHeight = value
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
    internal static var psdkViewOptions : ViewOptions! = ViewOptions() {
        didSet {
            initializeFonts()
        }
    }
    internal static var psdkNavBarHasImage : Bool = false
    internal static var psdkCardOptions : CardOptions! = CardOptions()
    internal static var psdkPageIndicatorOptions : PageIndicatorOptions! = PageIndicatorOptions()
    internal static var psdkFontOptions : FontStyleOptions! = FontStyleOptions()
    internal static var psdkTabOptions : TabStyleOptions! = TabStyleOptions()
    internal static var psdkCampaignSectionSequence : [CampaignSectionSequence] = [CampaignSectionSequence.Detail,  CampaignSectionSequence.Timing, CampaignSectionSequence.Store, CampaignSectionSequence.Bank]
    
    internal static func configure() {
        OCMapperConfig.configure()
    }
   
    public static func setCampaignSectionSequence(seq: [CampaignSectionSequence])  {
        psdkCampaignSectionSequence = seq
    }

    private static func initializeFonts() {
        
        BaseButton.appearance().sdkFontName = self.psdkViewOptions.fontRegular
        UITextField.appearance().sdkFontName = self.psdkViewOptions.fontRegular

        UISegmentedControl.appearance().tintColor = ProximateSDKSettings.psdkViewOptions.primaryColor
        UISegmentedControl.appearance().setTitleTextAttributes([NSFontAttributeName : UIFont(name: ProximateSDKSettings.psdkViewOptions.fontRegular, size: 16.0)!], forState: UIControlState.Normal)
//        UILabel.appearance().sdkFontName = "Futura"
//        UILabel.appearance().sdkBoldFontName = "Futura-CondensedExtraBold"
    }
    
    public static func configureSettingsPlist(plistName : String) {
        if let path = NSBundle.mainBundle().pathForResource(plistName, ofType: "plist"), dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
            DebugLogger.debugLog("path \(path)")
            DebugLogger.debugLog("dict \(dict)")
            
            if let fontStyles = dict["Font"] as? [String: AnyObject] {
                setFontStyle(fontStyles)
            }
            
            if let pageIndicatorStyles = dict["PageIndicator"] as? [String: AnyObject] {
                setPageIndicatorStyle(pageIndicatorStyles)
            }
            
            if let viewStyles = dict["View"] as? [String: AnyObject] {
                setViewStyles(viewStyles)
            }
            
            if let cardStyles = dict["Card"] as? [String: AnyObject] {
                setCardStyles(cardStyles)
            }
            
            if let tabStyles = dict["Tab"] as? [String: AnyObject] {
                setTabStyle(tabStyles)
            }
        }
    }
    
    public static func setTabStyleOptions(options: [PSDKTabOption])  {
        psdkTabOptions = TabStyleOptions(tabOptions: options)
    }

    private static func setTabStyle(tabStyles: [String: AnyObject])  {
        
        if let fValue = tabStyles["ViewBackgroundColor"], fColor = fValue as? String {
            psdkTabOptions.viewBackgroundColor = UIColor.hexToColor(fColor)
        }
        
        if let fValue = tabStyles["MenuHeight"], fHeight = fValue as? CGFloat {
            psdkTabOptions.menuHeight = fHeight
        }
        
        if let menuMarginStyle = tabStyles["MenuMargin"] as? [String: AnyObject] {
            if let fValue = menuMarginStyle["X"], fX = fValue as? CGFloat {
                psdkTabOptions.menuMarginX = fX
            }
            if let fValue = menuMarginStyle["Y"], fY = fValue as? CGFloat {
                psdkTabOptions.menuMarginY = fY
            }
        }
        if let menuItemLabelColorStyle = tabStyles["MenuItemLabelColor"] as? [String: AnyObject] {
            if let fValue = menuItemLabelColorStyle["Selected"], fColor = fValue as? String {
                psdkTabOptions.selectedMenuItemLabelColor = UIColor.hexToColor(fColor)
            }
            
            if let fValue = menuItemLabelColorStyle["Unselected"], fColor = fValue as? String {
                psdkTabOptions.unselectedMenuItemLabelColor = UIColor.hexToColor(fColor)
            }
        }
        if let menuItemBackgroundColorStyle = tabStyles["MenuItemBackgroundColor"] as? [String: AnyObject] {
            if let fValue = menuItemBackgroundColorStyle["Selected"], fColor = fValue as? String {
                psdkTabOptions.selectedMenuColor = UIColor.hexToColor(fColor)
            }
            
            if let fValue = menuItemBackgroundColorStyle["Unselected"], fColor = fValue as? String {
                psdkTabOptions.unselectedMenuColor = UIColor.hexToColor(fColor)
            }
        }
        if let menuItemBorderColorStyle = tabStyles["MenuItemBorderColor"] as? [String: AnyObject] {
            if let fValue = menuItemBorderColorStyle["Selected"], fColor = fValue as? String {
                psdkTabOptions.menuItemSelectedBorderColor = UIColor.hexToColor(fColor)
            }
            
            if let fValue = menuItemBorderColorStyle["Unselected"], fColor = fValue as? String {
                psdkTabOptions.menuItemUnselectedBorderColor = UIColor.hexToColor(fColor)
            }
        }
        if let fValue = tabStyles["MenuItemBorderWidth"], fWidth = fValue as? CGFloat {
            psdkTabOptions.menuItemBorderWidth = fWidth
        }
        if let fValue = tabStyles["MenuItemFontSize"], fSize = fValue as? CGFloat {
            psdkTabOptions.menuItemFontSize = fSize
        }
        if let fValue = tabStyles["ScrollAnimation"], fSize = fValue as? NSInteger {
            psdkTabOptions.scrollAnimationDurationOnMenuItemTap = fSize
        }

    }
    
    public static func setFontStyleOptions(options: [PSDKFontStyleOptions])  {
        psdkFontOptions = FontStyleOptions(fontOptions: options)
    }
    
    private static func setFontStyle(fontStyles: [String: AnyObject])  {
        let color = "Color", fontSize = "FontSize"
        if let seeAllStyles = fontStyles["SeeAll"] as? [String: AnyObject] {
            if let fValue = seeAllStyles[fontSize], fSize = fValue as? CGFloat {
                psdkFontOptions.seeAllFontSize = fSize
            }
            if let fValue = seeAllStyles[color], fColor = fValue as? String {
                psdkFontOptions.seeAllFontColor = UIColor.hexToColor(fColor)
            }
        }
       
        if let merchantTitleStyles = fontStyles["MerchantTitle"] as? [String: AnyObject] {
            if let fValue = merchantTitleStyles[fontSize], fSize = fValue as? CGFloat {
            	psdkFontOptions.merchantTitleFontSize = fSize
            }

            if let fValue = merchantTitleStyles[color], fColor = fValue as? String {
                psdkFontOptions.merchantTitleFontColor = UIColor.hexToColor(fColor)
            }
        }
        if let merchantTaglineStyles = fontStyles["MerchantTagline"] as? [String: AnyObject] {
            if let fValue = merchantTaglineStyles[fontSize], fSize = fValue as? CGFloat {
                psdkFontOptions.merchantTaglineFontSize = fSize
            }
            if let fValue = merchantTaglineStyles[color], fColor = fValue as? String {
                psdkFontOptions.merchantTaglineFontColor = UIColor.hexToColor(fColor)
            }
        }
        if let expiryTextStyles = fontStyles["ExpiryText"] as? [String: AnyObject] {
            if let fValue = expiryTextStyles[fontSize], fSize = fValue as? CGFloat {
                psdkFontOptions.expiryTextFontSize = fSize
            }
            if let fValue = expiryTextStyles[color], fColor = fValue as? String {
                psdkFontOptions.expiryTextFontColor = UIColor.hexToColor(fColor)
            }
            if let fValue2 = expiryTextStyles["ExpiredColor"] , fColor2 = fValue2 as? String {
                psdkFontOptions.expiredFontColor = UIColor.hexToColor(fColor2)
            }
        }
        if let campaignTitleStyles = fontStyles["CampaignTitle"] as? [String: AnyObject] {
            if let fValue = campaignTitleStyles[fontSize], fSize = fValue as? CGFloat {
                psdkFontOptions.campaignTextFontSize = fSize
            }
            if let fValue = campaignTitleStyles[color], fColor = fValue as? String {
                psdkFontOptions.campaignTextFontColor = UIColor.hexToColor(fColor)
            }
            if let fValue2 = campaignTitleStyles["BoldColor"], fColor2 = fValue2 as? String {
                psdkFontOptions.campaignBoldFontColor = UIColor.hexToColor(fColor2)
            }
        }
        
        if let campaignDetailStyles = fontStyles["CampaignDetail"] as? [String: AnyObject] {
            if let fValue = campaignDetailStyles[fontSize], fSize = fValue as? CGFloat {
                psdkFontOptions.campaignDetailTextSize = fSize
            }
            if let fValue2 = campaignDetailStyles["TitleFontSize"], fSize2 = fValue2 as? CGFloat {
                psdkFontOptions.campaignDetailTitleSize = fSize2
            }
            
            if let fValue = campaignDetailStyles[color], fColor = fValue as? String {
                psdkFontOptions.campaignDetailTextColor = UIColor.hexToColor(fColor)
            }
            if let fValue2 = campaignDetailStyles["TitleColor"], fColor2 = fValue2 as? String {
                psdkFontOptions.campaignDetailTitleColor = UIColor.hexToColor(fColor2)
            }
            if let fValue3 = campaignDetailStyles["BankOfferColor"], fColor3 = fValue3 as? String {
                psdkFontOptions.campaignDetailBankOfferColor = UIColor.hexToColor(fColor3)
            }
        }
        
    }
    
    public static func setPageIndicatorOptions(options: [PSDKPageIndicatorOptions])  {
        psdkPageIndicatorOptions = PageIndicatorOptions(pageIndicatorOptions: options)
    }

    private static func setPageIndicatorStyle(pageIndicatorStyles: [String: AnyObject])  {
       
        if let fValue = pageIndicatorStyles["PageSelectedColor"], fSelectedColor = fValue as? String {
            psdkPageIndicatorOptions.pageIndicatorSelectedColor = UIColor.hexToColor(fSelectedColor)
        }
        
        if let fValue = pageIndicatorStyles["PageUnselectedColor"], fUnselectedColor = fValue as? String {
            psdkPageIndicatorOptions.pageIndicatorUnselectedColor = UIColor.hexToColor(fUnselectedColor)
        }
        
        if let fValue = pageIndicatorStyles["PageIndicatorDiameter"], fDiameter = fValue as? CGFloat {
            psdkPageIndicatorOptions.pageIndicatorDiameter = fDiameter
        }
        if let fValue = pageIndicatorStyles["PageIndicatorSpace"], fSpace = fValue as? CGFloat {
            psdkPageIndicatorOptions.pageIndicatorSpace = fSpace
        }
    }
    
    public static func setViewOptions(options: [PSDKViewOptions])  {
        psdkViewOptions = ViewOptions(viewOptions: options)
    }
    
    private static func setViewStyles(viewStyles: [String: AnyObject])  {
    
        if let fValue = viewStyles["PrimaryColor"], fColor = fValue as? String {
            psdkViewOptions.primaryColor = UIColor.hexToColor(fColor)
        }
        
        if let fValue = viewStyles["ViewBackgroundColor"], fColor = fValue as? String {
            psdkViewOptions.viewBackgroundColor = UIColor.hexToColor(fColor)
        }
        
        if let fValue = viewStyles["NavigationBarTintColor"], fColor = fValue as? String {
            psdkViewOptions.navigationBarTintColor = UIColor.hexToColor(fColor)
        }
        
        if let fValue = viewStyles["NavigationBarImage"], fImage = fValue as? String {
            psdkViewOptions.navigationBarImage = ProximateSDKSettings.getImageForName(fImage)
        }

        if let fValue = viewStyles["SearchBarColor"], fColor = fValue as? String {
            psdkViewOptions.searchBarColor = UIColor.hexToColor(fColor)
        }

        if let navBarTitleStyles = viewStyles["NavigationBarTitle"] as? [String: AnyObject] {
            if let fValue = navBarTitleStyles["FontSize"], fSize = fValue as? CGFloat {
                psdkViewOptions.navigationBarTitleSize = fSize
            }
            if let fValue2 = navBarTitleStyles["Color"], fColor = fValue2 as? String {
                psdkViewOptions.navigationBarTitleColor = UIColor.hexToColor(fColor)
            }
        }
        
        if let fontStyles = viewStyles["Font"] as? [String: AnyObject] {
            if let fValue =  fontStyles["Regular"], fFont = fValue as? String {
                psdkViewOptions.fontRegular = fFont
            }
            if let fValue2 = fontStyles["Bold"], fFont = fValue2 as? String {
                psdkViewOptions.fontBold = fFont
            }
        }
        if let paddingStyles = viewStyles["Padding"] as? [String: AnyObject] {
            if let fValue =  paddingStyles["InnerPadding"], fInner = fValue as? CGFloat {
                psdkViewOptions.innerPadding = fInner
            }
            if let fValue2 = paddingStyles["OuterPadding"], fOuter = fValue2 as? CGFloat {
                psdkViewOptions.outerPadding = fOuter
            }
        }
        if let heightStyle = viewStyles["Height"] as? [String: AnyObject] {
            if let fValue =  heightStyle["CardHeight"], fHeight = fValue as? CGFloat {
                psdkViewOptions.cardHeight = fHeight
            }
            if let fValue2 = heightStyle["HeaderHeight"], fHeight = fValue2 as? CGFloat {
                psdkViewOptions.headerHeight = fHeight
            }
        }
    }
    
    public static func setCardOptions(cardOptions: [PSDKCardOptions]) {
        psdkCardOptions = CardOptions(cardOptions: cardOptions)
    }
    
    private static func setCardStyles(cardStyles: [String: AnyObject])  {
        if let fValue = cardStyles["CardBackgroundColor"], fColor = fValue as? String {
            psdkCardOptions.cardBackgroundColor = UIColor.hexToColor(fColor)
        }
        
        if let fValue = cardStyles["CardShadowColor"], fColor = fValue as? String {
            psdkCardOptions.cardShadowColor = UIColor.hexToColor(fColor)
        }
        
        if let fValue = cardStyles["CardBorderColor"], fColor = fValue as? String {
            psdkCardOptions.cardBorderColor = UIColor.hexToColor(fColor)
        }
        
        if let fValue = cardStyles["CardCornerRadius"], fRadius = fValue as? CGFloat {
            psdkCardOptions.cardCornerRadius = fRadius
        }
        
        if let fValue2 = cardStyles["CardShadowRadius"], fRadius = fValue2 as? CGFloat {
            psdkCardOptions.cardShadowRadius = fRadius
        }
    
        if let fValue = cardStyles["CardBorderWidth"], fWidth = fValue as? CGFloat {
            psdkCardOptions.cardBorderWidth = fWidth
        }
        if let cardShadowOffsetStyle = cardStyles["CardShadowOffset"] as? [String: AnyObject] {
            if let fValue =  cardShadowOffsetStyle["Width"], fWidth = fValue as? CGFloat {
                psdkCardOptions.cardShadowOffset.width = fWidth
            }
            if let fValue2 = cardShadowOffsetStyle["Height"], fHeight = fValue2 as? CGFloat {
                psdkCardOptions.cardShadowOffset.height = fHeight
            }
        }
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
