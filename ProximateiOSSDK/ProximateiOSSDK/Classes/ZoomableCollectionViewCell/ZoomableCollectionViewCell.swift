//
//  ZoomableCollectionViewCell.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 02/12/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit
import MediaPlayer

class ZoomableCollectionViewCell: UICollectionViewCell {
    var content : ObjectCampaignMedia!
    var videoViewCampaign : MPMoviePlayerController!
    @IBOutlet weak var scrollView : UIScrollView!
    
    @IBOutlet weak var collectionViewImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupVideoPlayer (){
        
        videoViewCampaign = MPMoviePlayerController(contentURL: NSURL(fileURLWithPath: content.path))
        videoViewCampaign.scalingMode = MPMovieScalingMode.AspectFit
        videoViewCampaign.movieSourceType = MPMovieSourceType.Streaming
        videoViewCampaign.view.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height )
        videoViewCampaign.view.backgroundColor = UIColor.blackColor()
        videoViewCampaign.controlStyle = MPMovieControlStyle.Embedded
        videoViewCampaign.backgroundView.backgroundColor = UIColor.blackColor()
        videoViewCampaign.repeatMode = MPMovieRepeatMode.None
        videoViewCampaign.fullscreen = true
        videoViewCampaign.playbackState
        self.addSubview(videoViewCampaign.view)
        videoViewCampaign.play()
        
    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return    self.collectionViewImage
    }
}