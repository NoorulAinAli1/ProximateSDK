//
//  CampaignHeaderView.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 29/11/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit
import DDPageControl

class CampaignHeaderView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    var delegate : CampaignInfoClickDelegate?
    @IBOutlet var btnWebsiteWidth : NSLayoutConstraint?
    @IBOutlet var btnLocationWidth : NSLayoutConstraint?
    var btnVideo : UIBarButtonItem?

    private let reuseCellIdentifier: String = "campaignCell"
    
    @IBOutlet var campaignCollectionView : UICollectionView!
    @IBOutlet var pageControl : DDPageControl! {
        didSet {
            pageControl.backgroundColor = UIColor.clearColor()
            pageControl.onColor = ProximateSDKSettings.psdkPageIndicatorOptions.pageIndicatorSelectedColor
            pageControl.offColor = ProximateSDKSettings.psdkPageIndicatorOptions.pageIndicatorUnselectedColor
            pageControl.indicatorDiameter = ProximateSDKSettings.psdkPageIndicatorOptions.pageIndicatorDiameter
            pageControl.indicatorSpace = ProximateSDKSettings.psdkPageIndicatorOptions.pageIndicatorSpace
        }
    }

    @IBOutlet var merchantLogo : ImageSuperView!
    
    @IBOutlet var merchantTitle : BaseLabel! {
        didSet {
            merchantTitle.setStyle(ProximateSDKSettings.psdkFontOptions.merchantTitleFontColor, size: ProximateSDKSettings.psdkFontOptions.merchantTitleFontSize)
        }
    }
    
    @IBOutlet var merchantSlogan : BaseLabel!{
        didSet {
            merchantSlogan.setStyle(ProximateSDKSettings.psdkFontOptions.merchantTaglineFontColor, size: ProximateSDKSettings.psdkFontOptions.merchantTaglineFontSize)
        }
    }
    
    @IBOutlet var btnLocation : UIButton!
    @IBOutlet var btnShare : UIButton!
    @IBOutlet var btnPhone : UIButton!
    @IBOutlet var btnWebsite : UIButton!
    
    private var mCampaign  : ObjectCampaign!
    private var campaignBannerColor : UIColor! = ProximateSDKSettings.psdkViewOptions.primaryColor
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
        let shareText = String(format: "psdk_campaign_share".localized, arguments: [self.mCampaign.title, ProximateSDK.getAppName(), ProximateSDK.getAppName()])
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
        self.campaignCollectionView.registerNib(UINib(nibName:"CampaignMediaCollectionViewCell", bundle:ProximateSDKSettings.getBundle()), forCellWithReuseIdentifier: reuseCellIdentifier)

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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btnPhone.hidden = !mCampaign.getMerchant().hasPhoneNumber()
        
        btnLocation.hidden = (mCampaign.beacons == nil)
        btnLocationWidth?.constant = (mCampaign.beacons == nil) ? 1 : self.btnShare.frame.width
        
        btnWebsite.hidden = !mCampaign.getMerchant().hasWebsite()
        btnWebsiteWidth?.constant = !mCampaign.getMerchant().hasWebsite() ? 1 : self.btnShare.frame.width
    }

    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mCampaign.getMedia().count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell : CampaignMediaCollectionViewCell  = campaignCollectionView.dequeueReusableCellWithReuseIdentifier(reuseCellIdentifier, forIndexPath: indexPath) as! CampaignMediaCollectionViewCell
        cell.frame.size = self.campaignCollectionView.frame.size
        cell.sizeToFit()
        let cMedia = mCampaign.getMedia()[indexPath.row]
        
        cell.setCampaignMedia(cMedia)
        let mediaType = CAMPAIGN_MEDIA_TYPE(rawValue: cMedia.type)!
        if mediaType == .Video {
            let videoImage =  ProximateSDKSettings.getImageForName("button_video_play")
            self.btnVideo = UIBarButtonItem(image: videoImage, style: .Plain, target: cell, action: #selector(CampaignMediaCollectionViewCell.videoButtonPressed))
            cell.barBtnVideo = self.btnVideo
            delegate?.didSetCampaignMediaVideo!()
        }

        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        delegate?.didClickOnCampaign!(mCampaign)

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
