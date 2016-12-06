//
//  ImageCenterButton.h
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 25/11/2016.
//  Copyright © 2016 ProximateiOSSDK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface ImageCenterButton : UIButton

// Round Image
@property(nonatomic) IBInspectable BOOL imageIsRound;
// Image Padding
@property(nonatomic) IBInspectable CGFloat padding;
// Border width
@property(nonatomic) IBInspectable CGFloat borderWidth;
// Spacing between imageview and textlabel
@property(nonatomic) IBInspectable CGFloat imageTextSpace;
// Maximum imageview size
@property(nonatomic) IBInspectable CGSize imageViewMaxSize;
// Button backgroundHighlighted
@property(nonatomic, strong) IBInspectable UIColor *backgroundHighlightedColor;
// Button backgroundNormal
@property(nonatomic, strong) IBInspectable UIColor *backgroundNormalColor;
// Border Color
@property(nonatomic, strong) IBInspectable UIColor *borderColor;

@end
