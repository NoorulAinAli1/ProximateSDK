//
//  VideoCampaignActionViewController.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 02/12/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation

class VideoCampaignActionViewController: BaseViewController {
    var mCampaignAction : ObjectCampaignAction!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = mCampaignAction.actionTitle
        
        setupVideoPlayer()
    }

    private func setupVideoPlayer (){
        
//        var videoViewCampaign = MPMoviePlayerController()
//        videoViewCampaign.contentURL = NSURL(string: self.mCampaignAction.media[0].getMediaURL())
//        
//        videoViewCampaign.scalingMode = MPMovieScalingMode.AspectFit
//        videoViewCampaign.movieSourceType = MPMovieSourceType.Streaming
//        videoViewCampaign.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height )
//        videoViewCampaign.view.backgroundColor = UIColor.blackColor()
//        videoViewCampaign.controlStyle = MPMovieControlStyle.Embedded
//        videoViewCampaign.repeatMode = MPMovieRepeatMode.None
//        videoViewCampaign.allowsAirPlay = true
//        videoViewCampaign.playbackState
//        videoViewCampaign.prepareToPlay()
//        videoViewCampaign.shouldAutoplay = true
//        self.view.addSubview(videoViewCampaign.view)

        
        let player = AVPlayer(URL:  NSURL(string: self.mCampaignAction.media[0].getMediaURL())!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        playerLayer.backgroundColor = UIColor.blackColor().CGColor
    
        self.view.layer.addSublayer(playerLayer)
        player.play()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
