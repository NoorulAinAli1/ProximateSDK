//  CAPSPageMenu.swift
//
//  Niklas Fahl
//
//  Copyright (c) 2014 The Board of Trustees of The University of Alabama All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  Neither the name of the University nor the names of the contributors may be used to endorse or promote products derived from this software without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
//  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
//  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
//  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import UIKit

class PaddedLabel : BaseLabel {
    @IBInspectable var inset: CGFloat = ProximateSDKSettings.psdkViewOptions.innerPadding
    
    override func drawTextInRect(rect: CGRect) {
        let insets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override func intrinsicContentSize() -> CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize()
        intrinsicSuperViewContentSize.height += inset + inset
        intrinsicSuperViewContentSize.width += inset + inset
        return intrinsicSuperViewContentSize
    }
}


@objc internal protocol CAPSPageMenuDelegate {
    // MARK: - Delegate functions
    
    optional func willMoveToPage(controller: UIViewController, index: Int)
    optional func didMoveToPage(controller: UIViewController, index: Int)
}

class MenuItemView: UIView {
    // MARK: - Menu item view
    var titleLabel : PaddedLabel?


    func setUpMenuItemView(menuItemWidth: CGFloat, menuItemSpacingY spacingY : CGFloat, menuScrollViewHeight: CGFloat, menuBorderColor borderColor : UIColor, menuBorderWidth borderWidth : CGFloat, menuShadowColor menuShadowColor : UIColor){
        titleLabel = PaddedLabel(frame: CGRectMake(0.0, spacingY, self.frame.width, self.frame.height))//CGRectMake(0.0, spacingY, menuItemWidth, menuScrollViewHeight - (spacingY*2)))
        titleLabel?.layer.masksToBounds = true
        titleLabel?.layer.cornerRadius = (menuScrollViewHeight - (spacingY*2))/2
        titleLabel?.layer.borderColor = borderColor.CGColor
        titleLabel?.layer.borderWidth = borderWidth
        titleLabel?.userInteractionEnabled  = true
        titleLabel?.textAlignment = NSTextAlignment.Center

        self.layer.masksToBounds = false
        self.backgroundColor = UIColor.clearColor()
        self.layer.cornerRadius = self.frame.height/2
        self.layer.borderColor = UIColor.clearColor().CGColor
        self.layer.borderWidth = borderWidth
        self.layer.shadowColor = menuShadowColor.CGColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 1.0
        self.userInteractionEnabled  = true
        self.addSubview(titleLabel!)
    }
    
    func setTitleText(text: NSString) {
        if titleLabel != nil {
            titleLabel!.text = text as String
            titleLabel!.numberOfLines = 0
            titleLabel!.sizeToFit()
        }
    }
}

internal class CAPSPageMenu: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate {
    
    // MARK: - Properties
    
    let menuScrollView = UIScrollView()
    var controllerScrollView : UICollectionView!
    var controllerArray : [UIViewController] = []
    var menuItems : [MenuItemView] = []
    var menuItemWidths : [CGFloat] = []
    
    internal var tabOptions : TabStyleOptions! = ProximateSDKSettings.psdkTabOptions

    internal var menuItemWidth : CGFloat = 111.0
    var totalMenuItemWidthIfDifferentWidths : CGFloat = 0.0
    var startingMenuMargin : CGFloat = 0.0
    
    var currentPageIndex : Int = 0
    var lastPageIndex : Int = 0
    
    internal var enableHorizontalBounce : Bool = false
    
    var currentOrientationIsPortrait : Bool = true
    var pageIndexForOrientationChange : Int = 0
    var didLayoutSubviewsAfterRotation : Bool = false
    var didScrollAlready : Bool = false
    
    var lastControllerScrollViewContentOffset : CGFloat = 0.0
    
    var lastScrollDirection : CAPSPageMenuScrollDirection = .Other
    var startingPageForScroll : Int = 0
    var didTapMenuItemToScroll : Bool = false
    
    internal weak var delegate : CAPSPageMenuDelegate?
    
    var tapTimer : NSTimer?
    
    enum CAPSPageMenuScrollDirection : Int {
        case Left
        case Right
        case Other
    }
    
    // MARK: - View life cycle
    
    /**
    Initialize PageMenu with view controllers
    
    :param: viewControllers List of view controllers that must be subclasses of UIViewController
    :param: frame Frame for page menu view
    :param: options Dictionary holding any customization options user might want to set
    */
    public init(viewControllers: [UIViewController], frame: CGRect, options: [String: AnyObject]?) {
        super.init(nibName: nil, bundle: nil)
        
        controllerArray = viewControllers
        
        self.view.frame = frame
    }
    
    internal convenience init(viewControllers: [UIViewController], frame: CGRect, pageMenuOptions: TabStyleOptions) {
        self.init(viewControllers:viewControllers, frame:frame, options:nil)
        
        self.tabOptions = pageMenuOptions
        
        setUpUserInterface()
        
        if menuScrollView.subviews.count == 0 {
            configureUserInterface()
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
	
	// MARK: - Container View Controller
	public override func shouldAutomaticallyForwardAppearanceMethods() -> Bool {
		return true
	}
	
	public override func shouldAutomaticallyForwardRotationMethods() -> Bool {
		return true
	}
	
    // MARK: - UI Setup
    
    func setUpUserInterface() {
        let layoutCollection = UICollectionViewFlowLayout()
        layoutCollection.scrollDirection = .Horizontal
        layoutCollection.minimumInteritemSpacing = 0
        layoutCollection.minimumLineSpacing = 0
        
        self.controllerScrollView = UICollectionView(frame: CGRectMake(0.0, self.tabOptions.menuHeight, self.view.frame.width, self.view.frame.height - self.tabOptions.menuHeight), collectionViewLayout: layoutCollection)
        self.controllerScrollView.dataSource = self
        self.controllerScrollView.delegate = self
        controllerScrollView.registerClass(TableCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "viewControllerCell")

        let viewsDictionary = ["menuScrollView":menuScrollView, "controllerScrollView":controllerScrollView]
        // Set up controller scroll view
        controllerScrollView.pagingEnabled = true
        controllerScrollView.translatesAutoresizingMaskIntoConstraints = false
        controllerScrollView.alwaysBounceHorizontal = enableHorizontalBounce
        controllerScrollView.bounces = enableHorizontalBounce
//        controllerScrollView.frame = CGRectMake(0.0, self.tabOptions.menuHeight, self.view.frame.width, self.view.frame.height)
        
        self.view.addSubview(controllerScrollView)
        
//        let controllerScrollView_constraint_H:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[controllerScrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
//        let controllerScrollView_constraint_V:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|[controllerScrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        
//        self.view.addConstraints(controllerScrollView_constraint_H)
//        self.view.addConstraints(controllerScrollView_constraint_V)
        
        // Set up menu scroll view
        menuScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        menuScrollView.frame = CGRectMake(0.0, 0.0, self.view.frame.width, tabOptions.menuHeight)
        
        self.view.addSubview(menuScrollView)
        
        let menuScrollView_constraint_H:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[menuScrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        let menuScrollView_constraint_V:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:[menuScrollView(\(self.tabOptions.menuHeight))]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        
        self.view.addConstraints(menuScrollView_constraint_H)
        self.view.addConstraints(menuScrollView_constraint_V)
        
        // Disable scroll bars
        menuScrollView.showsHorizontalScrollIndicator = false
        menuScrollView.showsVerticalScrollIndicator = false
        controllerScrollView.showsHorizontalScrollIndicator = false
        controllerScrollView.showsVerticalScrollIndicator = false
        
        // Set background color behind scroll views and for menu scroll view
        self.view.backgroundColor = self.tabOptions.viewBackgroundColor
        menuScrollView.backgroundColor = self.tabOptions.viewBackgroundColor
        
    }
    
    func configureUserInterface() {
        // Add tap gesture recognizer to controller scroll view to recognize menu item selection
        let menuItemTapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleMenuItemTap:"))
        menuItemTapGestureRecognizer.numberOfTapsRequired = 1
        menuItemTapGestureRecognizer.numberOfTouchesRequired = 1
        menuItemTapGestureRecognizer.delegate = self
        menuScrollView.addGestureRecognizer(menuItemTapGestureRecognizer)
        
        // Set delegate for controller scroll view
        controllerScrollView.delegate = self
        
        // When the user taps the status bar, the scroll view beneath the touch which is closest to the status bar will be scrolled to top,
        // but only if its `scrollsToTop` property is YES, its delegate does not return NO from `shouldScrollViewScrollToTop`, and it is not already at the top.
        // If more than one scroll view is found, none will be scrolled.
        // Disable scrollsToTop for menu and controller scroll views so that iOS finds scroll views within our pages on status bar tap gesture.
        menuScrollView.scrollsToTop = false;
        controllerScrollView.scrollsToTop = false;
        
        // Configure menu scroll view
        menuScrollView.contentSize = CGSizeMake((self.menuItemWidth + self.tabOptions.menuMarginX) * CGFloat(controllerArray.count) + self.tabOptions.menuMarginX, self.tabOptions.menuHeight)
        
        // Configure controller scroll view content size
//        controllerScrollView.contentSize = CGSizeMake(self.view.frame.width * CGFloat(controllerArray.count), 0.0)
        
        var index : CGFloat = 0.0
        
        for controller in controllerArray {
            if index == 0.0 {
                // Add first two controllers to scrollview and as child view controller
                addPageAtIndex(0)
            }
            
            // Set up menu item for menu scroll view
            var menuItemFrame : CGRect = CGRect()
            
            let controllerTitle : String? = controller.title
            
            let titleText : String = controllerTitle != nil ? controllerTitle! : "Menu \(Int(index) + 1)"
        
            let itemWidthRect : CGRect = (titleText as NSString).boundingRectWithSize(CGSizeMake(1000, 1000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(self.tabOptions.menuItemFontSize)], context: nil)
            let spacing : CGFloat = 50
            menuItemWidth = itemWidthRect.width + spacing
            
//            menuItemFrame = CGRectMake(totalMenuItemWidthIfDifferentWidths + self.tabOptions.menuMarginX + (self.tabOptions.menuMarginX * index), 0.0, menuItemWidth, self.tabOptions.menuHeight)
            menuItemFrame = CGRectMake(totalMenuItemWidthIfDifferentWidths + self.tabOptions.menuMarginX + (self.tabOptions.menuMarginX * index), 0, menuItemWidth, self.tabOptions.menuHeight - (self.tabOptions.menuMarginY*2))
            
            totalMenuItemWidthIfDifferentWidths += (itemWidthRect.width + spacing)
            menuItemWidths.append(itemWidthRect.width)
            
            let menuItemView : MenuItemView = MenuItemView(frame: menuItemFrame)

            menuItemView.setUpMenuItemView(menuItemWidth, menuItemSpacingY: self.tabOptions.menuMarginY, menuScrollViewHeight: self.tabOptions.menuHeight, menuBorderColor: self.tabOptions.menuItemUnselectedBorderColor, menuBorderWidth: self.tabOptions.menuItemBorderWidth, menuShadowColor: self.tabOptions.menuItemShadowColor)
            
            // Configure menu item label font if font is set by user
            menuItemView.titleLabel!.sdkFontSize = self.tabOptions.menuItemFontSize
            
            menuItemView.titleLabel!.textColor = self.tabOptions.unselectedMenuItemLabelColor
            menuItemView.titleLabel!.backgroundColor = self.tabOptions.unselectedMenuColor
            menuItemView.titleLabel!.layer.borderColor = self.tabOptions.menuItemUnselectedBorderColor.CGColor
            
            // Set title depending on if controller has a title set
            if controller.title != nil {
                menuItemView.titleLabel!.text = controller.title!
            } else {
                menuItemView.titleLabel!.text = "Menu \(Int(index) + 1)"
            }
            
            // Add menu item view to menu scroll view
            menuScrollView.addSubview(menuItemView)
            menuItems.append(menuItemView)
            
            index += 1
        }
        
        // Set new content size for menu scroll view if needed
        menuScrollView.contentSize = CGSizeMake((totalMenuItemWidthIfDifferentWidths + self.tabOptions.menuMarginX) + CGFloat(controllerArray.count) * self.tabOptions.menuMarginX, self.tabOptions.menuHeight)
    
        // Set selected color for title label of selected menu item
        if menuItems.count > 0 {
            if menuItems[currentPageIndex].titleLabel != nil {
                menuItems[currentPageIndex].titleLabel!.textColor = self.tabOptions.selectedMenuItemLabelColor
                menuItems[currentPageIndex].titleLabel!.backgroundColor = self.tabOptions.selectedMenuColor
                menuItems[currentPageIndex].titleLabel!.layer.borderColor = self.tabOptions.menuItemSelectedBorderColor.CGColor
            }
        }
        
        self.configureMenuItemWidthBasedOnTitleTextWidth()
        let leadingAndTrailingMargin = self.getMarginForMenuItemWidthBasedOnTitleTextWidth()
    
    }
    
    // Adjusts the menu item frames to size item width based on title text width and center all menu items in the center
    // if the menuItems all fit in the width of the view. Otherwise, it will adjust the frames so that the menu items
    // appear as if only menuItemWidthBasedOnTitleTextWidth is true.
    private func configureMenuItemWidthBasedOnTitleTextWidth() {
        // only center items if the combined width is less than the width of the entire view's bounds
        if menuScrollView.contentSize.width < CGRectGetWidth(self.view.bounds) {
            // compute the margin required to center the menu items
            let leadingAndTrailingMargin = self.getMarginForMenuItemWidthBasedOnTitleTextWidth()
            
            // adjust the margin of each menu item to make them centered
            for (index, menuItem) in menuItems.enumerate() {
                let controllerTitle = controllerArray[index].title!
                
                let itemWidthRect = controllerTitle.boundingRectWithSize(CGSizeMake(1000, 1000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes:  [NSFontAttributeName:UIFont.systemFontOfSize(self.tabOptions.menuItemFontSize)], context: nil)
                
                menuItemWidth = itemWidthRect.width
                
                var margin: CGFloat
                if index == 0 {
                    // the first menu item should use the calculated margin
                    margin = leadingAndTrailingMargin
                } else {
                    // the other menu items should use the menuMarginX
                    let previousMenuItem = menuItems[index-1]
                    let previousX = CGRectGetMaxX(previousMenuItem.frame)
                    margin = previousX + self.tabOptions.menuMarginX
                }
                
                menuItem.frame = CGRectMake(margin, 0.0, menuItemWidth, self.tabOptions.menuHeight)
            }
        } else {
            // the menuScrollView.contentSize.width exceeds the view's width, so layout the menu items normally (menuItemWidthBasedOnTitleTextWidth)
            for (index, menuItem) in menuItems.enumerate() {
                var menuItemX: CGFloat
                if index == 0 {
                    menuItemX = self.tabOptions.menuMarginX
                } else {
                    menuItemX = CGRectGetMaxX(menuItems[index-1].frame) + self.tabOptions.menuMarginX
                }
                
                menuItem.frame = CGRectMake(menuItemX, 0.0, CGRectGetWidth(menuItem.bounds), CGRectGetHeight(menuItem.bounds))
            }
        }
    }
    
    // Returns the size of the left and right margins that are neccessary to layout the menuItems in the center.
    private func getMarginForMenuItemWidthBasedOnTitleTextWidth() -> CGFloat {
        let menuItemsTotalWidth = menuScrollView.contentSize.width - self.tabOptions.menuMarginX * 2
        let leadingAndTrailingMargin = (CGRectGetWidth(self.view.bounds) - menuItemsTotalWidth) / 2
        
        return leadingAndTrailingMargin
    }
    
    // MARK: - Scroll view delegate
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        if !didLayoutSubviewsAfterRotation {
            if scrollView.isEqual(controllerScrollView) {
                if scrollView.contentOffset.x >= 0.0 && scrollView.contentOffset.x <= (CGFloat(controllerArray.count - 1) * self.view.frame.width) {
                    if (currentOrientationIsPortrait && UIApplication.sharedApplication().statusBarOrientation.isPortrait) || (!currentOrientationIsPortrait && UIApplication.sharedApplication().statusBarOrientation.isLandscape) {
                        // Check if scroll direction changed
                        if !didTapMenuItemToScroll {
                            if didScrollAlready {
                                var newScrollDirection : CAPSPageMenuScrollDirection = .Other
                                
                                if (CGFloat(startingPageForScroll) * scrollView.frame.width > scrollView.contentOffset.x) {
                                    newScrollDirection = .Right
                                } else if (CGFloat(startingPageForScroll) * scrollView.frame.width < scrollView.contentOffset.x) {
                                    newScrollDirection = .Left
                                }
                                
                                if newScrollDirection != .Other {
                                    if lastScrollDirection != newScrollDirection {
                                        let index : Int = newScrollDirection == .Left ? currentPageIndex + 1 : currentPageIndex - 1
                                    }
                                }
                                lastScrollDirection = newScrollDirection
                            }
                            
                            if !didScrollAlready {
                                if (lastControllerScrollViewContentOffset > scrollView.contentOffset.x) {
                                    if currentPageIndex != controllerArray.count - 1 {
                                        // Add page to the left of current page
                                        let index : Int = currentPageIndex - 1
                                        addPageAtIndex(index)
                                        lastScrollDirection = .Right
                                    }
                                } else if (lastControllerScrollViewContentOffset < scrollView.contentOffset.x) {
                                    if currentPageIndex != 0 {
                                        // Add page to the right of current page
                                        let index : Int = currentPageIndex + 1
                                        addPageAtIndex(index)
                                        lastScrollDirection = .Left
                                    }
                                }
                                didScrollAlready = true
                            }
                            lastControllerScrollViewContentOffset = scrollView.contentOffset.x
                        }
                        
                        var ratio : CGFloat = 1.0
                        let subView = menuScrollView.subviews[currentPageIndex]
                          // Calculate ratio between scroll views
                        ratio = (menuScrollView.contentSize.width - self.view.frame.width) / (controllerScrollView.contentSize.width - self.view.frame.width)
//                        DebugLogger.debugLog("ratio \(ratio)")
                        DebugLogger.debugLog("menuScrollView.contentOffset.x \(menuScrollView.contentOffset.x)")
                        DebugLogger.debugLog("menuScrollView.contentSize.width \(menuScrollView.contentSize.width)")
                        DebugLogger.debugLog("subView.frame.origin.x \(subView.frame.origin.x)")
                        let frameToCompare = menuScrollView.contentOffset.x + self.view.frame.width
                        DebugLogger.debugLog("mxa \(frameToCompare)")

                        var offset : CGPoint = menuScrollView.contentOffset
//                        if frameToCompare > subView.frame.origin.x {
//                            offset.x = subView.frame.origin.x
//                            if frameToCompare <= menuScrollView.contentSize.width {
//                                offset.x = subView.frame.origin.x
//                            } else {
                                offset.x = controllerScrollView.contentOffset.x * ratio
//                                offset.x -= subView.frame.width
//                            }
//                        }
//                        if offset.x + subView.frame.width <= subView.frame.origin.x {
//                            offset.x -= subView.frame.width/3
//                        }
//                        if (offset.x+subView.frame.width) < (menuScrollView.contentOffset.x - subView.frame.width) {
//                            offset.x = subView.frame.origin.x
//                        }
                        menuScrollView.setContentOffset(offset, animated: false)

                        // Calculate current page
                        let width : CGFloat = controllerScrollView.frame.size.width;
                        let page : Int = Int((controllerScrollView.contentOffset.x + (0.5 * width)) / width)
                        
                        // Update page if changed
                        if page != currentPageIndex {
                            lastPageIndex = currentPageIndex
                            currentPageIndex = page
        
                            if !didTapMenuItemToScroll {
                                let indexLeftTwo : Int = page - 2
                                let indexRightTwo : Int = page + 2
                            }
                        }
                        
                        // Move selection indicator view when swiping
                        moveSelectionIndicator(page)
                    }
                } else {
                    var ratio : CGFloat = 1.0
                    
                    ratio = (menuScrollView.contentSize.width - self.view.frame.width) / (controllerScrollView.contentSize.width - self.view.frame.width)
                    
                    if menuScrollView.contentSize.width > self.view.frame.width {
                        var offset : CGPoint = menuScrollView.contentOffset
                        offset.x = controllerScrollView.contentOffset.x * ratio
//                        menuScrollView.setContentOffset(offset, animated: false)
                    }
                }
            }
        } else {
            didLayoutSubviewsAfterRotation = false
        
//             Move selection indicator view when swiping
            moveSelectionIndicator(currentPageIndex)
        }
    }
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView.isEqual(controllerScrollView) {
            // Call didMoveToPage delegate function
            let currentController = controllerArray[currentPageIndex]
            delegate?.didMoveToPage?(currentController, index: currentPageIndex)
            
            didScrollAlready = false
            startingPageForScroll = currentPageIndex
        
        }
    }
    
    func scrollViewDidEndTapScrollingAnimation() {
        // Call didMoveToPage delegate function
        let currentController = controllerArray[currentPageIndex]
        delegate?.didMoveToPage?(currentController, index: currentPageIndex)
    
        startingPageForScroll = currentPageIndex
        didTapMenuItemToScroll = false
    }
    
//    // MARK: - Handle Selection Indicator
    func moveSelectionIndicator(pageIndex: Int) {
        if pageIndex >= 0 && pageIndex < controllerArray.count {
            UIView.animateWithDuration(0.15, animations: { () -> Void in
                // Switch newly selected menu item title label to selected color and old one to unselected color
                if self.menuItems.count > 0 {
                    if self.menuItems[self.lastPageIndex].titleLabel != nil && self.menuItems[self.currentPageIndex].titleLabel != nil {
                        self.menuItems[self.lastPageIndex].titleLabel!.textColor = self.tabOptions.unselectedMenuItemLabelColor
                        self.menuItems[self.lastPageIndex].titleLabel!.backgroundColor = self.tabOptions.unselectedMenuColor
                        self.menuItems[self.lastPageIndex].titleLabel!.layer.borderColor = self.tabOptions.menuItemUnselectedBorderColor.CGColor

                        self.menuItems[self.currentPageIndex].titleLabel!.textColor = self.tabOptions.selectedMenuItemLabelColor
                        self.menuItems[self.currentPageIndex].titleLabel!.backgroundColor = self.tabOptions.selectedMenuColor
                        self.menuItems[self.currentPageIndex].titleLabel!.layer.borderColor = self.tabOptions.menuItemSelectedBorderColor.CGColor
                    }
                }
            })
        }
    }
    
    // MARK: - Tap gesture recognizer selector
    
    func handleMenuItemTap(gestureRecognizer : UITapGestureRecognizer) {
        let tappedPoint : CGPoint = gestureRecognizer.locationInView(menuScrollView)
        
        if tappedPoint.y < menuScrollView.frame.height {
            
            // Calculate tapped page
            var itemIndex : Int = 0
        
            var menuItemLeftBound: CGFloat
            var menuItemRightBound: CGFloat
            
                menuItemLeftBound = CGRectGetMinX(menuItems[0].frame)
                menuItemRightBound = CGRectGetMaxX(menuItems[menuItems.count-1].frame)
                
                if (tappedPoint.x >= menuItemLeftBound && tappedPoint.x <= menuItemRightBound) {
                    for (index, _) in controllerArray.enumerate() {
                        menuItemLeftBound = CGRectGetMinX(menuItems[index].frame)
                        menuItemRightBound = CGRectGetMaxX(menuItems[index].frame)
                        
                        if tappedPoint.x >= menuItemLeftBound && tappedPoint.x <= menuItemRightBound {
                            itemIndex = index
                            break
                        }
                    }
                }
       
            if itemIndex >= 0 && itemIndex < controllerArray.count {
                // Update page if changed
                if itemIndex != currentPageIndex {
                    startingPageForScroll = itemIndex
                    lastPageIndex = currentPageIndex
                    currentPageIndex = itemIndex
                    didTapMenuItemToScroll = true
                    
                    // Add pages in between current and tapped page if necessary
                    let smallerIndex : Int = lastPageIndex < currentPageIndex ? lastPageIndex : currentPageIndex
                    let largerIndex : Int = lastPageIndex > currentPageIndex ? lastPageIndex : currentPageIndex
                    
                    if smallerIndex + 1 != largerIndex {
                        for index in (smallerIndex + 1)...(largerIndex - 1) {
                            addPageAtIndex(index)
                        }
                    }
    
                    addPageAtIndex(itemIndex)
                }
            }
        }
    }
    
    
    // MARK: - Remove/Add Page
    func addPageAtIndex(index : Int) {
        currentPageIndex = index
        let indexPath = NSIndexPath(forItem: currentPageIndex, inSection: 0)
//        self.controllerScrollView.selectItemAtIndexPath(indexPath, animated: true, scrollPosition: .None)
        self.controllerScrollView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: true)

        let currentController = controllerArray[currentPageIndex]
        delegate?.didMoveToPage!(currentController, index: currentPageIndex)

    }
    
    // MARK: - Orientation Change
    
    override public func viewDidLayoutSubviews() {
        // Configure controller scroll view content size
//        controllerScrollView.contentSize = CGSizeMake(self.view.frame.width * CGFloat(controllerArray.count), self.view.frame.height - self.tabOptions.menuHeight)
        
        let oldCurrentOrientationIsPortrait : Bool = currentOrientationIsPortrait
        currentOrientationIsPortrait = UIApplication.sharedApplication().statusBarOrientation.isPortrait
        
        if (oldCurrentOrientationIsPortrait && UIDevice.currentDevice().orientation.isLandscape) || (!oldCurrentOrientationIsPortrait && UIDevice.currentDevice().orientation.isPortrait) {
            didLayoutSubviewsAfterRotation = true
            
            //Resize menu items if using as segmented control
            self.configureMenuItemWidthBasedOnTitleTextWidth()
            let selectionIndicatorX = CGRectGetMinX(menuItems[currentPageIndex].frame)
            
            for view : UIView in controllerScrollView.subviews {
                view.frame = CGRectMake(self.view.frame.width * CGFloat(currentPageIndex), self.tabOptions.menuHeight, controllerScrollView.frame.width, self.view.frame.height - self.tabOptions.menuHeight)
            }
            
            let xOffset : CGFloat = CGFloat(self.currentPageIndex) * controllerScrollView.frame.width
//            controllerScrollView.setContentOffset(CGPoint(x: xOffset, y: controllerScrollView.contentOffset.y), animated: false)
            
            let ratio : CGFloat = (menuScrollView.contentSize.width - self.view.frame.width) / (controllerScrollView.contentSize.width - self.view.frame.width)
            
            if menuScrollView.contentSize.width > self.view.frame.width {
                var offset : CGPoint = menuScrollView.contentOffset
                offset.x = controllerScrollView.contentOffset.x * ratio
                menuScrollView.setContentOffset(offset, animated: false)
            }
        }
        
        // Hsoi 2015-02-05 - Running on iOS 7.1 complained: "'NSInternalInconsistencyException', reason: 'Auto Layout
        // still required after sending -viewDidLayoutSubviews to the view controller. ViewController's implementation
        // needs to send -layoutSubviews to the view to invoke auto layout.'"
        //
        // http://stackoverflow.com/questions/15490140/auto-layout-error
        //
        // Given the SO answer and caveats presented there, we'll call layoutIfNeeded() instead.
        self.view.layoutIfNeeded()
    }
    
    // MARK: - Move to page index
    
    /**
    Move to page at index
    
    :param: index Index of the page to move to
    */
    internal func moveToPage(index: Int) {
        if index >= 0 && index < controllerArray.count {
            // Update page if changed
            if index != currentPageIndex {
                startingPageForScroll = index
                lastPageIndex = currentPageIndex
                currentPageIndex = index
                didTapMenuItemToScroll = true
                
                // Add pages in between current and tapped page if necessary
                let smallerIndex : Int = lastPageIndex < currentPageIndex ? lastPageIndex : currentPageIndex
                let largerIndex : Int = lastPageIndex > currentPageIndex ? lastPageIndex : currentPageIndex
                
                if smallerIndex + 1 != largerIndex {
                    for i in (smallerIndex + 1)...(largerIndex - 1) {
                        addPageAtIndex(i)
                    }
                }
                addPageAtIndex(index)
            }
        }
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.controllerArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell : TableCollectionViewCell  = collectionView.dequeueReusableCellWithReuseIdentifier("viewControllerCell", forIndexPath: indexPath) as! TableCollectionViewCell
        
        let table = self.controllerArray[indexPath.row] as! CategoryTableViewController

        cell.addSubview(table.tableView)
        cell.sizeToFit()
        return cell
    }

    func collectionView(collectionView: UICollectionView!,
                        layout collectionViewLayout: UICollectionViewLayout!,
                               sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        return self.controllerScrollView.bounds.size
    }
}
