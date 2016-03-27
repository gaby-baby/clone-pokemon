//
//  MonsterAnimate.m
//  viewSwapping
//
//  Created by Gabriel A Lau on 2016-03-27.
//  Copyright © 2016 Gabriel A Lau. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "MonsterAnimate.h"

@implementation MonsterAnimate {
    SKSpriteNode *_monster;
    NSArray *_monsterFrames;
}
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = UIColorFromRGB(0x009ECE);
    }
    return self;
}
@end
