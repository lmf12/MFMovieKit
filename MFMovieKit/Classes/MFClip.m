//
//  MFClip.m
//  MFMovieKit
//
//  Created by Lyman Li on 2019/12/7.
//  Copyright © 2019 Lyman Li. All rights reserved.
//

#import "MFClip.h"

@interface MFClip ()

@property (nonatomic, strong, readwrite) AVAsset *asset;

@end

@implementation MFClip

- (instancetype)initWithAsset:(AVAsset *)asset {
    self = [super init];
    if (self) {
        _asset = asset;
    }
    return self;
}

+ (instancetype)clipWithAsset:(AVAsset *)asset {
    return [[self alloc] initWithAsset:asset];
}

#pragma mark - Custom Accessor

- (CMTimeRange)timeRange {
    return CMTimeRangeMake(kCMTimeZero, self.asset.duration);
}

@end
