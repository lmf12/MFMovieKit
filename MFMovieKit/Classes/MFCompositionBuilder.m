//
//  MFCompositionBuilder.m
//  MFMovieKit
//
//  Created by Lyman Li on 2019/12/7.
//  Copyright © 2019 Lyman Li. All rights reserved.
//

#import "MFCompositionBuilder.h"

@interface MFCompositionBuilder ()

@property (nonatomic, strong) MFTimeLine *timeLine;
@property (nonatomic, strong) AVMutableComposition *mutComposition;

@end

@implementation MFCompositionBuilder

- (instancetype)initWithTimeLine:(MFTimeLine *)timeLine {
    self = [super init];
    if (self) {
        _timeLine = timeLine;
    }
    return self;
}

+ (instancetype)compositionBuilderWithTimeLine:(MFTimeLine *)timeLine {
    return [[self alloc] initWithTimeLine:timeLine];
}

#pragma mark - Public

- (MFComposition *)bulidComposition {
    self.mutComposition = [AVMutableComposition composition];
    
    for (NSArray<MFClip *> *clips in self.timeLine.clips) {
        [self addCompositionTrackOfType:AVMediaTypeVideo clips:clips];
    }
    return [MFComposition compositionWithComposition:[self.mutComposition copy]];
}

#pragma mark - Private

/// 根据轨道类型，添加轨道
- (void)addCompositionTrackOfType:(NSString *)mediaType
                            clips:(NSArray<MFClip *> *)clips {
    if (clips.count == 0) {
        return;
    }
    CMPersistentTrackID trackID = kCMPersistentTrackID_Invalid;
    AVMutableCompositionTrack *compositionTrack = [self.mutComposition addMutableTrackWithMediaType:mediaType preferredTrackID:trackID];
    
    CMTime cursorTime = kCMTimeZero;
    for (MFClip *clip in clips) {
        if (CMTIME_COMPARE_INLINE(clip.startTime, !=, kCMTimeInvalid)) {
            cursorTime = clip.startTime;
        }
        NSError *error = nil;
        AVAssetTrack *assetTrack = [[clip.asset tracksWithMediaType:mediaType] firstObject];
        [compositionTrack insertTimeRange:clip.timeRange
                                  ofTrack:assetTrack
                                   atTime:cursorTime
                                    error:&error];
        NSAssert(!error, error.description);
        cursorTime = CMTimeAdd(cursorTime, clip.timeRange.duration);
    }
}

@end
