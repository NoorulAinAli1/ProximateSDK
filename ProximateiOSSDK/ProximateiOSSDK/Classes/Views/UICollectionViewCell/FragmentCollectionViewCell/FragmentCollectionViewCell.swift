//
//  FragmentCollectionViewCell.swift
//  ProximateiOSSDK
// 
//  Created by Noor ul Ain Ali on 12/06/2015.
//  Copyright (c) 2015 Avanza Solutions. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation

class FragmentCollectionViewCell: UICollectionViewCell {
    
    var mCampaignMedia : ObjectCampaignMedia!
    var videoViewCampaign : MPMoviePlayerController!
    @IBOutlet var collectionViewImage: UIImageView!
   
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
        if mCampaignMedia.type == "6601" { // image type
            self.setUpImageView()
            
        } else if mCampaignMedia.type == "6602" { // video type
            collectionViewImage.hidden = true
            setupVideoPlayer()
            videoViewCampaign.view.hidden = false
        }
       
    }
    
    private func setUpImageView(){
        collectionViewImage.backgroundColor = UIColor.whiteColor()
        collectionViewImage.af_setImageWithURL(NSURL(string: self.mCampaignMedia.getMediaURL())!, placeholderImage: UIImage(named: "placeholder_campaign.png"))
        collectionViewImage.hidden = false
        if videoViewCampaign !=  nil {
            videoViewCampaign.view.hidden = true
        }
        self.collectionViewImage.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
//        self.addSubview(collectionViewImage)
    }
    
    private func setupVideoPlayer (){

        videoViewCampaign = MPMoviePlayerController()
        videoViewCampaign.contentURL = NSURL(string: self.mCampaignMedia.path)

        videoViewCampaign.scalingMode = MPMovieScalingMode.AspectFit
        videoViewCampaign.movieSourceType = MPMovieSourceType.Streaming
        videoViewCampaign.view.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height )
        videoViewCampaign.view.backgroundColor = UIColor.blackColor()
        videoViewCampaign.controlStyle = MPMovieControlStyle.Embedded
        videoViewCampaign.repeatMode = MPMovieRepeatMode.None
//        videoViewCampaign.fullscreen = true

        videoViewCampaign.playbackState
        videoViewCampaign.prepareToPlay()
        videoViewCampaign.shouldAutoplay = false
        videoViewCampaign.view.hidden = false
        
        self.addSubview(videoViewCampaign.view)
//        let videoURL = NSURL(string: self.content.path)
//        let player = AVPlayer(URL: videoURL!)
//        let playerLayer = AVPlayerLayer(player: player)
//        playerLayer.frame = self.bounds
//       let view = self.contentView.viewWithTag(101)
//        view?.layer.addSublayer(playerLayer)
//        player.play()
    }
}
