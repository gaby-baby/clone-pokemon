//
//  MonsterAnimate.m
//  viewSwapping
//
//  Created by Gabriel A Lau on 2016-03-27.
//  Copyright © 2016 Gabriel A Lau. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "MonsterAnimate.h"
@import CoreMotion;

@interface MonsterAnimate()
@property (nonatomic, strong) CMMotionManager * motionManager;
@end

@implementation MonsterAnimate {
    SKSpriteNode *_monster;
    NSArray *_monsterFrames;
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = UIColorFromRGB(0x009ECE);
        
        //Setup the array to hold the walking frames
        NSMutableArray *standFrames = [NSMutableArray array];
        
        //Load the TextureAtlas for the bear
        SKTextureAtlas *gumdropAnimatedAtlas = [SKTextureAtlas atlasNamed:@"gumdrop"];
        
        //Load the animation frames from the TextureAtlas
        int numImages = gumdropAnimatedAtlas.textureNames.count;
        for (int i=1; i <= numImages; i++) {
            NSString *textureName = [NSString stringWithFormat:@"frame-%d", i];
            SKTexture *temp = [gumdropAnimatedAtlas textureNamed:textureName];
            [standFrames addObject:temp];
        }
        _monsterFrames=standFrames;
        
        //Create bear sprite, setup position in middle of the screen, and add to Scene
        SKTexture *temp = _monsterFrames[0];
        _monster = [SKSpriteNode spriteNodeWithTexture:temp];
        _monster.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:_monster];
        
        //Start the bear walking
        [self moveMonster];
    }
    return self;
}

-(void)moveMonster
{
    //This is our general runAction method to make our bear walk.
    //By using a withKey if this gets called while already running it will remove the first action before
    //starting this again.
    
    [_monster runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:_monsterFrames
                                                                    timePerFrame:0.1f
                                                                          resize:NO
                                                                         restore:YES]] withKey:@"moveMonster"];
    return;
}
@end
