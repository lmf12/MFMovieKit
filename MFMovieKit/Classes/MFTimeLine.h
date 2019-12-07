//
//  MFTimeLine.h
//  MFMovieKit
//
//  Created by Lyman Li on 2019/12/7.
//  Copyright © 2019 Lyman Li. All rights reserved.
//

#import "MFClip.h"

@interface MFTimeLine : NSObject

@property (nonatomic, copy) NSArray<NSArray<MFClip *> *> *clips;

/// 检查是否存在视频片段
- (BOOL)hasClip;

@end
