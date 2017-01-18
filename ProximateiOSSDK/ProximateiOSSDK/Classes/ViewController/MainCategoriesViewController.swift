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

class MainCategoriesViewController: BaseViewController, CAPSPageMenuDelegate, UITextFieldDelegate {

    var pageMenu : CAPSPageMenu?
    var navSearchView : SearchCategoryView? = nil
    var mCategories : [ObjectCategory] = []
    var controllerArray : [UITableViewController] = []

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
   
        let backImage =  ProximateSDKSettings.getImageForName("button_back")
        let btnBack : UIBarButtonItem = UIBarButtonItem(image: backImage, style: .Plain, target: self, action: #selector(MainCategoriesViewController.removeSDK(_:)))

        self.navigationItem.leftBarButtonItem = btnBack
        
        let searchImage =  ProximateSDKSettings.getImageForName("button_search")
        
        let btnSearch : UIBarButtonItem = UIBarButtonItem(image: searchImage, style: .Plain, target: self, action: #selector(MainCategoriesViewController.showSearchView(_:)))
        
        self.navigationItem.rightBarButtonItem = btnSearch
        
        self.mCategories.append(ObjectCategory())
        ApiHandler.sharedInstance.getAllCategories ({
            categories in
            self.mCategories.appendContentsOf(categories)
            self.initializeTabs()
        })
      
        self.title = "psdk_title_merchant_list".localized
    }
    
    func removeSDK(sender: UIBarButtonItem){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showSearchView(sender: UIBarButtonItem){
        DebugLogger.debugLog("showSearchView")
        
        if (navSearchView == nil) {
            navSearchView = (ProximateSDKSettings.getBundle().loadNibNamed("SearchCategoryView", owner: self, options: nil)!.first as! SearchCategoryView)
            navSearchView!.frame = (self.navigationController?.navigationBar.bounds)!
            navSearchView!.btnClose.addTarget(self, action: #selector(MainCategoriesViewController.removeSearchView(_:)), forControlEvents: .TouchUpInside)
            navSearchView!.btnSearch.addTarget(self, action: #selector(MainCategoriesViewController.performSearch), forControlEvents: .TouchUpInside)
            self.navSearchView!.transform = CGAffineTransformMakeTranslation(self.navSearchView!.frame.width, 0.0)

            self.navigationController?.navigationBar.addSubview(navSearchView!)
        }
        navSearchView?.searchBar.delegate = self
        navSearchView!.slideInFromRight()
        DebugLogger.debugLog("showSearchView \(navSearchView!)")
    }
   
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        performSearch()
        return true
    }

    func performSearch(){
        if(navSearchView!.searchBar.text!.isEmpty){
            // show Error
            ProximateSDK.getMessageDelegate()?.showMessage("psdk_message_please_enter_some_search_criteria".localized)
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
        
        let storyBoard = UIStoryboard(name: "ProximateSDK", bundle: ProximateSDKSettings.getBundle())

        for category in mCategories {
            let viewController = storyBoard.instantiateViewControllerWithIdentifier("CategoryTableViewController") as! CategoryTableViewController
                viewController.mCategory = category
            viewController.title = category.getCategoryTitle()
            viewController.parentNavigationController = self.navigationController
            //            controller3.view.backgroundColor = getRandomColor()
            controllerArray.append(viewController)
        }
       
        
        // Initialize scroll menu
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: ProximateSDKSettings.psdkTabOptions)
        
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
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = ProximateSDKSettings.psdkViewOptions.primaryColor
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
