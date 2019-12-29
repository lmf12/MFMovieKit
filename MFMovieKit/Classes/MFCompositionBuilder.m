//
//  MFCompositionBuilder.m
//  MFMovieKit
//
//  Created by Lyman Li on 2019/12/7.
//  Copyright © 2019 Lyman Li. All rights reserved.
//

#import "MFVideoCompositionInstruction.h"

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

- (AVVideoComposition *)bulidVideoComposition {
    if (!self.mutComposition) {
        [self bulidComposition];
    }
    AVVideoComposition *videoComposition = [AVVideoComposition videoCompositionWithPropertiesOfAsset:self.mutComposition];
    NSArray *instructions = [self instructionsInComposition:videoComposition];
    for (MFVideoCompositionInstruction *instruction in instructions) {
        CMTimeRange timeRange = instruction.videoCompositionInstruction.timeRange;
        if (CMTimeRangeEqual(timeRange, kCMTimeRangeInvalid)) {
            continue;
        }
        instruction.videoCompositionInstruction.timeRange = timeRange;
        AVMutableVideoCompositionLayerInstruction *fromLayer = instruction.fromLayerInstruction;
        AVMutableVideoCompositionLayerInstruction *toLayer = instruction.toLayerInstruction;
        
        // TODO: 根据 videoTransition 来设置专场效果
        [fromLayer setOpacityRampFromStartOpacity:1.0
                                     toEndOpacity:0.0
                                        timeRange:timeRange];
        [toLayer setOpacityRampFromStartOpacity:0.0
                                   toEndOpacity:1.0
                                      timeRange:timeRange];
        
        instruction.videoCompositionInstruction.layerInstructions = @[fromLayer, toLayer];
    }
    return videoComposition;
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
    
    for (MFClip *clip in clips) {
        NSError *error = nil;
        AVAssetTrack *assetTrack = [[clip.asset tracksWithMediaType:mediaType] firstObject];
        [compositionTrack insertTimeRange:clip.timeRange
                                  ofTrack:assetTrack
                                   atTime:clip.startTime
                                    error:&error];
        NSAssert(!error, error.description);
    }
}

- (NSArray<MFVideoCompositionInstruction *> *)instructionsInComposition:(AVVideoComposition *)videoComposition {
    NSMutableArray *instructions = [[NSMutableArray alloc] init];
    __block NSInteger layerInstructionIndex = 0;
    NSArray *compositionInstructions = videoComposition.instructions;
    
    [compositionInstructions enumerateObjectsUsingBlock:^(AVMutableVideoCompositionInstruction *instruction, NSUInteger idx, BOOL *stop) {
        if (instruction.layerInstructions.count == 2) {
            MFVideoCompositionInstruction *vci = [[MFVideoCompositionInstruction alloc] init];
            vci.videoCompositionInstruction = instruction;
            vci.fromLayerInstruction = [instruction.layerInstructions[layerInstructionIndex] mutableCopy];
            vci.toLayerInstruction = [instruction.layerInstructions[1 - layerInstructionIndex] mutableCopy];
            if (idx < self.timeLine.videoTransitions.count) {
                vci.videoTransition = self.timeLine.videoTransitions[idx];
            }
            layerInstructionIndex = (layerInstructionIndex + 1) % 2;
            [instructions addObject:vci];
        }
    }];
    return instructions;
}

@end
