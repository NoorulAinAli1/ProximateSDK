//
//  CampaignTableViewCell.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 27/11/2016.
//  Copyright © 2016 ProximateiOSSDK. All rights reserved.
//

import UIKit
import QuartzCore

class CampaignTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    @IBOutlet var mainView : UIView!
    
    @IBOutlet var promotionImage : UIImageView!
    @IBOutlet var campaignNewImage : UIImageView!
    var delegate : CampaignInfoClickDelegate?

    @IBOutlet var campaignExpiryImage : UIImageView!
    
    @IBOutlet var campaignCollectionView : UICollectionView!
    
    @IBOutlet var campaignTitle : UILabel!
    @IBOutlet var campaignExpiryDateTime : UILabel!
    
    @IBOutlet var btnLocation : ImageCenterButton!
    @IBOutlet var btnShare : ImageCenterButton!
    @IBOutlet var pageControl : UIPageControl!

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
        let shareText = String(format: "psdk__campaign_share".localized, arguments: [self.mainCampaign.title, self.mainCampaign.getMerchant().merchantName, self.mainCampaign.details, ])
        delegate?.didClickCampaignShare(shareText)
    }
  
    func setCampaign(campaign : ObjectCampaign){
        self.campaignCollectionView.registerNib(UINib(nibName:"FragmentCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: "cell")
        
        mainCampaign  = campaign
        mainView.borderAndShadow()

        pageControl.numberOfPages =  (mainCampaign.getMedia().count)
        campaignCollectionView.pagingEnabled = true
    }
    
    private func updateCampaign(){
        campaignTitle.text = mainCampaign.getCampaignTitle()
        
        let expiryStyle = mainCampaign.getCampaignExpiryStyle()
        campaignExpiryDateTime.textColor = expiryStyle.campaignExpiryTextColor
        campaignExpiryImage.image = expiryStyle.campaignExpiryImage
        campaignExpiryDateTime.text = expiryStyle.campaignExpiryText
        
        btnLocation.hidden = (mainCampaign.beacons == nil)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainCampaign.getMedia().count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell : FragmentCollectionViewCell  = campaignCollectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! FragmentCollectionViewCell
        
        cell.frame.size = self.campaignCollectionView.frame.size
        cell.sizeToFit()
        cell.setCampaignMedia(mainCampaign.getMedia()[indexPath.row])
       
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell =  collectionView.cellForItemAtIndexPath(indexPath) as! FragmentCollectionViewCell
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
//        let cell =  cell as! FragmentCollectionViewCell
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
//        let cell : FragmentCollectionViewCell  = campaignCollectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! FragmentCollectionViewCell
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
