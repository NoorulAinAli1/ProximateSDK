//
//  MainCategoriesViewController.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 24/11/2016.
//  Copyright © 2016 ProximateiOSSDK. All rights reserved.
//

import UIKit

protocol SearchDelegate{
    func didClickOnSearch(search : String)
    func didCancelSearch()
}

class MainCategoriesViewController: UIViewController, CAPSPageMenuDelegate {
    var pageMenu : CAPSPageMenu?
    var navSearchView : SearchCategoryView? = nil
    var mCategories : [ObjectCategory] = []
    var controllerArray : [UITableViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        let searchImage =  UIImage(named: "button_search", inBundle: ProximateSDK.getBundle(), compatibleWithTraitCollection: nil)!

        let btnSearch : UIBarButtonItem = UIBarButtonItem(image: searchImage, style: .Plain, target: self, action: #selector(MainCategoriesViewController.showSearchView(_:)))

        self.navigationItem.rightBarButtonItem = btnSearch
        
        self.mCategories.append(ObjectCategory())
        ApiHandler.sharedInstance.getAllCategories ({
            categories in
            self.mCategories.appendContentsOf(categories)
            self.initializeTabs()
            DebugLogger.debugLog("categories \(categories)")
        })
        
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.lightGrayColor()
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.purpleColor()
//        UIPageControl.appearance().backgroundColor = UIColor.cyanColor()
      
        UISegmentedControl.appearance().tintColor = UIColor.psdkPrimaryColor()
//        UISegmentedControl.appearance().backgroundColor = UIColor.cyanColor()

//        // Customize menu (Optional)
//        var parameters: [CAPSPageMenuOption] = [
//            .ScrollMenuBackgroundColor(UIColor.orangeColor()),
//            .ViewBackgroundColor(UIColor.whiteColor()),
//            .SelectionIndicatorColor(UIColor.whiteColor()),
//            .UnselectedMenuItemLabelColor(UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.4)),
//            .MenuItemFont(UIFont(name: "HelveticaNeue", size: 35.0)!),
//            .MenuHeight(44.0),
//            .MenuMargin(20.0),
//            .SelectionIndicatorHeight(0.0),
//            .BottomMenuHairlineColor(UIColor.orangeColor()),
//            .MenuItemWidthBasedOnTitleTextWidth(true),
//            .SelectedMenuItemLabelColor(UIColor.whiteColor())
//        ]
        
        self.title = "Merchant List"
        self.navigationController?.navigationBar.barTintColor = UIColor.psdkPrimaryColor()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
    
    func showSearchView(sender: UIBarButtonItem){
        DebugLogger.debugLog("showSearchView")
        
        if (navSearchView == nil) {
            navSearchView = ProximateSDK.getBundle().loadNibNamed("SearchCategoryView", owner: self, options: nil)!.first as? SearchCategoryView
            navSearchView!.frame = (self.navigationController?.navigationBar.bounds)!
            navSearchView!.btnClose.addTarget(self, action: #selector(MainCategoriesViewController.removeSearchView(_:)), forControlEvents: .TouchUpInside)
            navSearchView!.btnSearch.addTarget(self, action: #selector(MainCategoriesViewController.performSearch(_:)), forControlEvents: .TouchUpInside)
            self.navSearchView!.transform = CGAffineTransformMakeTranslation(self.navSearchView!.frame.width, 0.0)

            self.navigationController?.navigationBar.addSubview(navSearchView!)
        }
        navSearchView!.slideInFromRight()
        DebugLogger.debugLog("showSearchView \(navSearchView!)")
    }
    
    func performSearch(sender : UIButton){
        if(navSearchView!.searchBar.text!.isEmpty){
            // show Error
            ProximateSDK.getMessageDelegate()?.showMessage("toast_please_enter_some_search_criteria".localized)
        } else {
            let vC = controllerArray[(pageMenu?.currentPageIndex)!] as! CategoryTableViewController
            DebugLogger.debugLog("vC \(vC)")
            vC.didClickOnSearch((navSearchView?.searchBar.text)!)
        }
    }
    
    func removeSearchView(sender : UIButton){
        navSearchView?.slideOutFromRight(completionDelegate : self )
        navSearchView?.searchBar.text!.removeAll()
        
        let vC = controllerArray[(pageMenu?.currentPageIndex)!] as! CategoryTableViewController
        DebugLogger.debugLog("vC \(vC)")
        vC.didCancelSearch()
    }
    
    func initializeTabs(){
        mCategories.sortInPlace { $0.getCategoryTitle().compare($1.getCategoryTitle()) == .OrderedAscending }
        
        let storyBoard = UIStoryboard(name: "ProximateSDK", bundle: ProximateSDK.getBundle())

        for category in mCategories {
            let viewController = storyBoard.instantiateViewControllerWithIdentifier("CategoryTableViewController") as! CategoryTableViewController
                viewController.mCategory = category
            viewController.title = category.getCategoryTitle()
            viewController.parentNavigationController = self.navigationController
            //            controller3.view.backgroundColor = getRandomColor()
            controllerArray.append(viewController)
        }
        
        // Customize menu (Optional)
        var parameters: [CAPSPageMenuOption] = [
//            .ScrollMenuBackgroundColor(UIColor.clearColor()),
//            .ViewBackgroundColor(UIColor.blackColor()),
//            .SelectionIndicatorColor(UIColor.orangeColor()),
//            .AddBottomMenuHairline(false),
//            .MenuItemFont(UIFont(name: "HelveticaNeue", size: 20.0)!),
//            .MenuHeight(30.0),
//            .SelectionIndicatorHeight(0.0),
//            .MenuItemWidthBasedOnTitleTextWidth(true),
//            .SelectedMenuItemLabelColor(UIColor.orangeColor())
        ]
        
        // Initialize scroll menu
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        
        pageMenu?.delegate = self
        self.view.addSubview(pageMenu!.view)
        
        let vC = controllerArray[(pageMenu?.currentPageIndex)!] as! CategoryTableViewController
        DebugLogger.debugLog("vC \(vC)")
        vC.didCancelSearch()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navSearchView?.alpha = 0.0
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navSearchView?.alpha = 1.0
        ProximateSDK.getScreenInteractionDelegate()?.screenInteracted()
    }
    
    
    func didMoveToPage(controller: UIViewController, index: Int) {
        DebugLogger.debugLog("didMoveToPage \(controller)")
        let vC = controller as! CategoryTableViewController
        if ((navSearchView?.searchBar.text!.isEmpty) != nil) {
            vC.didClickOnSearch(navSearchView!.searchBar.text!)
        } else {
            vC.didClickOnSearch("")
        }
        ProximateSDK.getScreenInteractionDelegate()?.screenInteracted()
    }
    
    func willMoveToPage(controller: UIViewController, index: Int) {
        DebugLogger.debugLog("willMoveToPage \(controller)")
       
    }
}
