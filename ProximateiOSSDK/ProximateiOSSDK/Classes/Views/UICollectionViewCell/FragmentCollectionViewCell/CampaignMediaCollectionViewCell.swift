//
//  CampaignMediaCollectionViewCell.swift
//  ProximateiOSSDK
// 
//  Created by Noor ul Ain Ali on 12/06/2015.
//  Copyright (c) 2015 Avanza Solutions. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation

class CampaignMediaCollectionViewCell: UICollectionViewCell {
    
    var mCampaignMedia : ObjectCampaignMedia!
    var videoViewCampaign : MPMoviePlayerController!
    @IBOutlet var collectionViewImage: UIImageView!
    @IBOutlet var videoButton: UIButton!
    private var isVideoPlaying : Bool = false
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.customize()
    }
    
    override func awakeFromNib() {
        self.customize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.customize()
    }
    
    func customize(){

    }
    
    func setCampaignMedia(content : ObjectCampaignMedia){
        mCampaignMedia = content
        
        let mediaType = CAMPAIGN_MEDIA_TYPE(rawValue: mCampaignMedia.type)!
        videoButton.hidden = mediaType != .Video
        switch mediaType {
            case .Image:
                collectionViewImage.af_setImageWithURL(NSURL(string: self.mCampaignMedia.getMediaURL())!, placeholderImage: ProximateSDKSettings.getLoadingPlaceholderImage())
                
                collectionViewImage.hidden = false
                if videoViewCampaign !=  nil {
                    videoViewCampaign.view.hidden = true
                }
                
                self.collectionViewImage.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]

            case .Video:
                setupVideoPlayer()
            default:
            DebugLogger.debugLog("no view")
        }

    }
    
    private func setUpImageView(){
        collectionViewImage.backgroundColor = UIColor.whiteColor()
        collectionViewImage.af_setImageWithURL(NSURL(string: self.mCampaignMedia.getMediaURL())!, placeholderImage: ProximateSDKSettings.getLoadingPlaceholderImage())
        
        collectionViewImage.hidden = false
        if videoViewCampaign !=  nil {
            videoViewCampaign.view.hidden = true
        }
        self.collectionViewImage.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    }
    
    private func setupVideoPlayer (){
        collectionViewImage.hidden = true

        videoViewCampaign = MPMoviePlayerController()
        videoViewCampaign.contentURL = NSURL(string: self.mCampaignMedia.path)

        videoViewCampaign.scalingMode = MPMovieScalingMode.AspectFit
        videoViewCampaign.movieSourceType = MPMovieSourceType.Streaming
        videoViewCampaign.view.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height )
        videoViewCampaign.view.backgroundColor = UIColor.blackColor()
        videoViewCampaign.controlStyle = MPMovieControlStyle.None
        videoViewCampaign.repeatMode = MPMovieRepeatMode.None
        videoViewCampaign.prepareToPlay()
        videoViewCampaign.shouldAutoplay = false
        videoViewCampaign.view.hidden = false
        
        videoViewCampaign.allowsAirPlay = true
        self.insertSubview(videoViewCampaign.view, atIndex: 0)
    }
    
    @IBAction func videoButtonPressed(){
        
        var imageName : UIImage
        if isVideoPlaying {
            imageName = ProximateSDKSettings.getImageForName("button_video_play")
            videoViewCampaign.pause()
        } else {
            imageName = ProximateSDKSettings.getImageForName("button_video_pause")
            videoViewCampaign.play()
        }
      
        self.videoButton.setImage(imageName, forState: .Normal)
        self.isVideoPlaying = !self.isVideoPlaying
    }
}
