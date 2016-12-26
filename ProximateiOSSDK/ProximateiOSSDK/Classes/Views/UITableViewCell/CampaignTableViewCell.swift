//
//  CampaignTableViewCell.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 27/11/2016.
//  Copyright © 2016 ProximateiOSSDK. All rights reserved.
//

import UIKit
import QuartzCore
import DDPageControl

class CampaignTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    @IBOutlet var mainView : CardView! {
        didSet {
            self.backgroundColor = UIColor.clearColor()
            self.contentView.backgroundColor = UIColor.clearColor()
        }
    }
    
    @IBOutlet var viewSpacing : [NSLayoutConstraint]!
    let reuseCellIdentifier: String = "campaignCell"
    
    var delegate : CampaignInfoClickDelegate?

    @IBOutlet var campaignExpiryImage : UIImageView!
    
    @IBOutlet var campaignCollectionView : UICollectionView!
    
    @IBOutlet var campaignTitle : BaseLabel! {
        didSet {
            campaignTitle.setStyle(ProximateSDKSettings.psdkFontOptions.campaignTextFontColor, size: ProximateSDKSettings.psdkFontOptions.campaignTextFontSize)
        }
    }

    @IBOutlet var campaignExpiryDateTime : BaseLabel!
    
    @IBOutlet var btnLocation : UIButton!
    @IBOutlet var btnShare :UIButton!
    @IBOutlet var pageControl : DDPageControl! {
        didSet {
            pageControl.onColor = ProximateSDKSettings.psdkPageIndicatorOptions.pageIndicatorSelectedColor
            pageControl.offColor = ProximateSDKSettings.psdkPageIndicatorOptions.pageIndicatorUnselectedColor
            pageControl.indicatorDiameter = ProximateSDKSettings.psdkPageIndicatorOptions.pageIndicatorDiameter
            pageControl.indicatorSpace = ProximateSDKSettings.psdkPageIndicatorOptions.pageIndicatorSpace
        }
    }

    private var mainCampaign : ObjectCampaign! {
        didSet {
            updateCampaign()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func campaignLocationClicked() {
        delegate?.didClickCampaignLocation(mainCampaign)
    }
    
    @IBAction func campaignShareClicked() {
        let shareText = String(format: "psdk_campaign_share".localized, arguments: [self.mainCampaign.title, self.mainCampaign.getMerchant().merchantName, ProximateSDK.getAppName() ])
        delegate?.didClickCampaignShare(shareText)
    }
  
    private func setOuterSpacing() {
        for item in self.viewSpacing {
            item.constant = ProximateSDKSettings.psdkViewOptions.outerPadding
        }
    }
    
    func setCampaign(campaign : ObjectCampaign){
        setOuterSpacing()
        self.campaignCollectionView.registerNib(UINib(nibName:"CampaignMediaCollectionViewCell", bundle:ProximateSDKSettings.getBundle()), forCellWithReuseIdentifier: reuseCellIdentifier)
        
        mainCampaign  = campaign

        pageControl.hidesForSinglePage = true
        pageControl.numberOfPages =  (mainCampaign.getMedia().count)
        campaignCollectionView.pagingEnabled = true
        campaignCollectionView.bounces = false
    }
    
    private func updateCampaign(){
        campaignTitle.setHTMLFromString(mainCampaign.getCampaignTitle())

        let expiryStyle = mainCampaign.getCampaignExpiryStyle()
//        campaignExpiryDateTime.textColor = expiryStyle.campaignExpiryTextColor
        campaignExpiryImage.image = expiryStyle.campaignExpiryImage
        campaignExpiryDateTime.text = expiryStyle.campaignExpiryText
        campaignExpiryDateTime.setStyle(expiryStyle.campaignExpiryTextColor, size: ProximateSDKSettings.psdkFontOptions.expiryTextFontSize)
        
        btnLocation.hidden = (mainCampaign.beacons == nil)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainCampaign.getMedia().count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell : CampaignMediaCollectionViewCell  = campaignCollectionView.dequeueReusableCellWithReuseIdentifier( reuseCellIdentifier, forIndexPath: indexPath) as! CampaignMediaCollectionViewCell
        
        cell.frame.size = self.campaignCollectionView.frame.size
        cell.sizeToFit()
        if (mainCampaign.getMedia().count > 0){
            DebugLogger.debugLog("media url \(mainCampaign.getMedia()[indexPath.row])")
            cell.setCampaignMedia(mainCampaign.getMedia()[indexPath.row])
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        delegate?.didClickOnCampaign!(mainCampaign)
//        let cell =  collectionView.cellForItemAtIndexPath(indexPath) as! CampaignMediaCollectionViewCell
//        if cell.content.type == "6601" {
//            pageControl.currentPage = indexPath.row
//            
//            let campId : NSNumber = self.mainCampaign.getCampaignId()
////            DebugLogger.debugLog("selected Campaign \(campId) and showDetail \(self.shouldShowDetail)")
////            delegate?.didClickOnCampaignImage(self.campaign.campaignId, showDetail: self.shouldShowDetail)
//            
//        } else if cell.content.type == "6602"{
//            if cell.videoViewCampaign.playbackState == .Playing {
//                cell.videoViewCampaign.pause()
//            } else{
//                cell.videoViewCampaign.play()
//                
//            }
//        }
    }
    
//    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
//        
//        let cell =  cell as! CampaignMediaCollectionViewCell
////        if cell.content.type == "6601" { // image type
////            
////        } else if cell.content.type == "6602"{ // video type
////            
////            cell.videoViewCampaign.view.hidden = true
////            cell.collectionViewImage.hidden = false
////            cell.videoViewCampaign.stop()
////        }
//    }
//
//    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
//        pageControl.currentPage = indexPath.row
//        let cell : CampaignMediaCollectionViewCell  = campaignCollectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CampaignMediaCollectionViewCell
//        cell.backgroundColor = UIColor.clearColor()
//    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(mainView.frame.width, campaignCollectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView.isKindOfClass(UICollectionView){
            let collectionView  = scrollView as! UICollectionView
            let pageWidth = collectionView.frame.size.width - 1
            let currentIndex = collectionView.contentOffset.x / pageWidth
            pageControl.currentPage = Int(currentIndex)
            
//            DebugLogger.debugLog("currentIndex \(currentIndex)")
//            DebugLogger.debugLog("content offset \(collectionView.contentOffset.x)")
//            DebugLogger.debugLog("pageWidth  \(pageWidth)")
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
