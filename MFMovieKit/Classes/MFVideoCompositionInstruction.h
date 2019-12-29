//
//  MFVideoCompositionInstruction.h
//  SimpleMovie
//
//  Created by Lyman Li on 2019/12/29.
//  Copyright © 2019 Lyman Li. All rights reserved.
//

#import "MFVideoTransition.h"

@interface MFVideoCompositionInstruction : NSObject

@property (nonatomic, strong) MFVideoTransition *videoTransition;

@property (nonatomic, strong) AVMutableVideoCompositionInstruction *videoCompositionInstruction;
@property (nonatomic, strong) AVMutableVideoCompositionLayerInstruction *fromLayerInstruction;
@property (nonatomic, strong) AVMutableVideoCompositionLayerInstruction *toLayerInstruction;

@end
