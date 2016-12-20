//
//  MediaPagerViewController.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 02/12/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit
import DDPageControl

internal enum CAMPAIGN_MEDIA_TYPE : String {
    case Image  = "6601"
    case Video  = "6602"
    case PDF    = "6603"
    case Word   = "6604"
    case Doc    = "6605"
    case PPT    = "6606"
}

class MediaPagerFullScreenViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var screenTitle : String!
    var mediaItem :[ObjectCampaignMedia]! = [ObjectCampaignMedia]()
    @IBOutlet var contentsCollectionView : UICollectionView!
    @IBOutlet var pageControl : DDPageControl! {
        didSet {
            pageControl.onColor = ProximateSDKSettings.psdkPageIndicatorOptions.pageIndicatorSelectedColor
            pageControl.offColor = ProximateSDKSettings.psdkPageIndicatorOptions.pageIndicatorUnselectedColor
            pageControl.indicatorDiameter = ProximateSDKSettings.psdkPageIndicatorOptions.pageIndicatorDiameter
            pageControl.indicatorSpace = ProximateSDKSettings.psdkPageIndicatorOptions.pageIndicatorSpace
        }
    }

    @IBOutlet var crossBtn : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.screenTitle
        self.view.backgroundColor = UIColor.blackColor()
        self.contentsCollectionView.pagingEnabled = true
        self.contentsCollectionView.backgroundColor = UIColor.blackColor()
        self.pageControl.numberOfPages = self.mediaItem.count
        self.pageControl.hidesForSinglePage = true
        self.pageControl.backgroundColor = UIColor.clearColor()
        contentsCollectionView.reloadData()
    }
    
    
    /*
     * MARK : - CollectionView Delegate & Datasource
     */
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mediaItem.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("zoomableCollectionCell", forIndexPath: indexPath) as! ZoomableCollectionViewCell
        cell.backgroundColor = UIColor.blackColor()
        
        if indexPath.row == 0 {
            self.pageControl.currentPage = indexPath.row
            
        }
        cell.content = self.mediaItem[indexPath.row]
        
        cell.collectionViewImage.frame.size = cell.frame.size
        let mediaType = CAMPAIGN_MEDIA_TYPE(rawValue: cell.content.type)!

        switch mediaType {
        case .Image:
            cell.collectionViewImage.af_setImageWithURL(NSURL(string: cell.content.getMediaURL())!,placeholderImage: ProximateSDKSettings.getLoadingPlaceholderImage())
            cell.scrollView.minimumZoomScale = 1.0
            cell.scrollView.maximumZoomScale = 3.0
            cell.scrollView.frame.size = self.view.frame.size
            cell.scrollView.contentSize =  self.view.frame.size
        case .Video:
            cell.collectionViewImage.hidden = true
            cell.setupVideoPlayer()
            cell.scrollView.minimumZoomScale = 1.0
            cell.scrollView.maximumZoomScale = 1.0
        default:
            DebugLogger.debugLog("no view")
        }
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        self.pageControl.currentPage = indexPath.row
    }
    
    func collectionView(collectionView: UICollectionView!,
                        layout collectionViewLayout: UICollectionViewLayout!,
                               sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        return self.view.frame.size
    }
    
    @IBAction func crossBtnPressed(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
//        self.navigationController?.navigationBar.hidden = false
    }


}