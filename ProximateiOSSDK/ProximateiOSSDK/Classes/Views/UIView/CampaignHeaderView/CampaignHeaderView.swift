//
//  CampaignHeaderView.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 29/11/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit

class CampaignHeaderView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    var delegate : CampaignInfoClickDelegate?
    @IBOutlet var promotionImage : UIImageView!
    @IBOutlet var campaignNewImage : UIImageView!
   
    @IBOutlet var campaignCollectionView : UICollectionView!
    @IBOutlet var pageControl : UIPageControl!

    @IBOutlet var merchantLogo : ImageSuperView!
    
    @IBOutlet var merchantTitle : UILabel!
    @IBOutlet var merchantSlogan : UILabel!
    
    @IBOutlet var btnLocation : ImageCenterButton!
    @IBOutlet var btnShare : ImageCenterButton!
    @IBOutlet var btnPhone : ImageCenterButton!
    @IBOutlet var btnWebsite : ImageCenterButton!
    
    private var mCampaign  : ObjectCampaign!
    private var campaignBannerColor : UIColor! = UIColor.psdkPrimaryColor()
    private let colorCube = CCColorCube()

    override init(frame : CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func campaignLocationClicked() {
        delegate?.didClickCampaignLocation(mCampaign)
    }
   
    @IBAction func campaignShareClicked() {
        let shareText = String(format: "psdk__campaign_share".localized, arguments: [self.mCampaign.title, self.mCampaign.getMerchant().merchantName, self.mCampaign.details, ])
        delegate?.didClickCampaignShare(shareText)
    }
    
    @IBAction func campaignPhoneClicked() {
        delegate?.didClickCampaignPhone!()
    }
    
    @IBAction func campaignWebsiteClicked() {
        delegate?.didClickCampaignWebsite!()
    }
    
    func setCampaign(campaign : ObjectCampaign){
        mCampaign = campaign
        self.campaignCollectionView.registerNib(UINib(nibName:"FragmentCollectionViewCell", bundle:ProximateSDK.getBundle()), forCellWithReuseIdentifier: "cell")

        merchantTitle.text = campaign.getMerchant().merchantName
        merchantSlogan.text = campaign.getMerchant().tagLine

        let imgView = UIImageView()
        imgView.af_setImageWithURL(NSURL(string: campaign.getMerchantLogo())!,  completion: { response in
            self.merchantLogo.image = response.result.value
        })
        
        let mainImgView = UIImageView()
        mainImgView.af_setImageWithURL(NSURL(string: campaign.getMainMedia().getMediaURL())!,  completion: { response in
            if response.result.error == nil {

            let bannerImage = response.result.value
            let colors = self.colorCube.extractColorsFromImage(bannerImage!, flags: CCAvoidWhite.rawValue) as! [UIColor]
            self.campaignBannerColor = colors[0]

//            self.campaignBannerColor = bannerImage?.averageImageColor()
            }
        })

        
        pageControl.hidesForSinglePage = true
        pageControl.numberOfPages =  (mCampaign.getMedia().count)
        campaignCollectionView.pagingEnabled = true
        
        btnPhone.hidden = campaign.getMerchant().hasPhoneNumber()
        btnWebsite.hidden = campaign.getMerchant().hasWebsite()
        btnLocation.hidden = (campaign.beacons == nil)

    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mCampaign.getMedia().count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell : FragmentCollectionViewCell  = campaignCollectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! FragmentCollectionViewCell
        
        cell.frame.size = self.campaignCollectionView.frame.size
        cell.sizeToFit()
        cell.setCampaignMedia(mCampaign.getMedia()[indexPath.row])
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        let cell =  collectionView.cellForItemAtIndexPath(indexPath) as! FragmentCollectionViewCell
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
        return CGSizeMake(self.frame.width, campaignCollectionView.frame.height)
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

    func getAverageColor () -> UIColor? {
        return self.campaignBannerColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

}
