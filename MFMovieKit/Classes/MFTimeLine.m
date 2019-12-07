//
//  MFTimeLine.m
//  MFMovieKit
//
//  Created by Lyman Li on 2019/12/7.
//  Copyright © 2019 Lyman Li. All rights reserved.
//

#import "MFTimeLine.h"

@implementation MFTimeLine

#pragma mark - Public

- (BOOL)hasClip {
    if (self.clips.count == 0) {
        return NO;
    }
    for (NSArray *array in self.clips) {
        if (array.count > 0) {
            return YES;
        }
    }
    return NO;
}

@end
