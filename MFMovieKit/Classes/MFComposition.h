//
//  MFComposition.h
//  MFMovieKit
//
//  Created by Lyman Li on 2019/12/7.
//  Copyright © 2019 Lyman Li. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface MFComposition : NSObject

- (instancetype)initWithComposition:(AVComposition *)composition;

+ (instancetype)compositionWithComposition:(AVComposition *)composition;

/// 创建可播放项目
- (AVPlayerItem *)createPlayerItem;

/// 创建可导出项目
- (AVAssetExportSession *)createAssetExportSession;
 
@end
