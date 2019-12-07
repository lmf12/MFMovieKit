//
//  MFComposition.m
//  MFMovieKit
//
//  Created by Lyman Li on 2019/12/7.
//  Copyright © 2019 Lyman Li. All rights reserved.
//

#import "MFComposition.h"

@interface MFComposition ()

@property (nonatomic, strong) AVComposition *composition;

@end

@implementation MFComposition

- (instancetype)initWithComposition:(AVComposition *)compositioin {
    self = [super init];
    if (self) {
        _composition = compositioin;
    }
    return self;
}

+ (instancetype)compositionWithComposition:(AVComposition *)composition {
    return [[self alloc] initWithComposition:composition];
}

#pragma mark - Public

- (AVPlayerItem *)createPlayerItem {
    return [[AVPlayerItem alloc] initWithAsset:[self.composition copy]];
}

- (AVAssetExportSession *)createAssetExportSession {
    NSString *preset = AVAssetExportPresetHighestQuality;
    return [[AVAssetExportSession alloc] initWithAsset:[self.composition copy]
                                            presetName:preset];
}

@end
