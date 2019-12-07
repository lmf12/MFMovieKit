//
//  MFClip.h
//  MFMovieKit
//
//  Created by Lyman Li on 2019/12/7.
//  Copyright © 2019 Lyman Li. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface MFClip : NSObject

@property (nonatomic, assign) CMTime startTime;
@property (nonatomic, assign, readonly) CMTimeRange timeRange;

@property (nonatomic, strong, readonly) AVAsset *asset;

- (instancetype)initWithAsset:(AVAsset *)asset;

+ (instancetype)clipWithAsset:(AVAsset *)asset;

@end
