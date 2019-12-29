//
//  MFCompositionBuilder.h
//  MFMovieKit
//
//  Created by Lyman Li on 2019/12/7.
//  Copyright © 2019 Lyman Li. All rights reserved.
//

#import "MFTimeLine.h"
#import "MFComposition.h"

@interface MFCompositionBuilder : NSObject

- (instancetype)initWithTimeLine:(MFTimeLine *)timeLine;

+ (instancetype)compositionBuilderWithTimeLine:(MFTimeLine *)timeLine;

- (MFComposition *)bulidComposition;

- (AVVideoComposition *)bulidVideoComposition;

@end
