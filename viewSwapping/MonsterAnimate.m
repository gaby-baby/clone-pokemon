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
    SKSpriteNode *_goNode;
    SKLabelNode *hello;
    NSArray *_monsterFrames;
    NSTimer *shakeTimer;
    float xTotal;
    float yTotal;
    float zTotal;
    
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        //Set Background
        self.backgroundColor = UIColorFromRGB(0x009ECE);
        
        //Initialize Motion Manager
        self.motionManager = [[CMMotionManager alloc] init];
        self.motionManager.deviceMotionUpdateInterval = 1.0 / 60.0;
        xTotal=0.0;
        yTotal=0.0;
        zTotal=0.0;
        
        
        //Create Sprite Array
        NSMutableArray *standFrames = [NSMutableArray array];
        SKTextureAtlas *gumdropAnimatedAtlas = [SKTextureAtlas atlasNamed:@"gumdrop"];
        //Load the animation frames from the TextureAtlas
        int numImages = gumdropAnimatedAtlas.textureNames.count;
        for (int i=1; i <= numImages; i++) {
            NSString *textureName = [NSString stringWithFormat:@"frame-%d", i];
            SKTexture *temp = [gumdropAnimatedAtlas textureNamed:textureName];
            [standFrames addObject:temp];
        }
        _monsterFrames=standFrames;
        
        
        SKTexture *temp = _monsterFrames[0];
        _monster = [SKSpriteNode spriteNodeWithTexture:temp];
        _monster.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)*1.2);
        _monster.zPosition = 1.0;
        [self addChild:_monster];
        
        //Add Button
        _goNode = [SKSpriteNode spriteNodeWithImageNamed:@"img/button.png"];
        _goNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)*0.2);
        _goNode.name = @"goButtonNode";
        _goNode.zPosition = 2.0;
        [self addChild:_goNode];
        
        //Add Label For Count Down
        hello = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
        hello.text = @"3";
        hello.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)*0.9);
        hello.hidden = TRUE;
        hello.zPosition = 4.0;
        [self addChild:hello];
        
        [self moveMonster];
    }
    return self;
}
//handle touch events
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    //if fire button touched, bring the rain
    if ([node.name isEqualToString:@"goButtonNode"]) {
        id prep = [SKAction runBlock:^{
            hello.hidden = FALSE;
            _monster.hidden = TRUE;
            _goNode.hidden = TRUE;
        }];
        id scaleup = [SKAction scaleTo:10.0 duration:1.5];
        id scaledown = [SKAction scaleTo:1.0 duration:0.2];
        id hide = [SKAction runBlock:^{
            hello.text=[NSString stringWithFormat:@"%i",[hello.text intValue]-1];
        }];
        id shake = [SKAction runBlock:^{
            hello.text=@"SHAKE!!";
        }];
        [hello runAction:[SKAction sequence:@[prep,scaleup,scaledown,hide,prep,scaleup,scaledown,hide,prep,scaleup,[SKAction scaleTo:3.0 duration:0.2],shake,[SKAction runBlock:^{
            [self.motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryCorrectedZVertical];
            shakeTimer=[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateDeviceMotion) userInfo:nil repeats:YES];
            [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(killtimer) userInfo:nil repeats:NO];
        }]
        ]]];
        
    }
}

-(void)updateDeviceMotion
{
    CMDeviceMotion *deviceMotion = self.motionManager.deviceMotion;
    if(deviceMotion == nil)
    {
        return;
    }
    CMAcceleration userAcceleration = deviceMotion.userAcceleration;
    float accX = userAcceleration.x;
    float accY = userAcceleration.y;
    float accZ = userAcceleration.z;
    xTotal+=fabsf(accX);
    yTotal+=fabsf(accY);
    zTotal+=fabsf(accZ);
    NSLog(@"accx: %f accy: %f accz: %f",accX,accY,accZ);
    
    
}

-(void)killtimer{
    [shakeTimer invalidate];
    shakeTimer = nil;
    [self showResults];
   
}

-(void)showResults{
    float total = xTotal+yTotal+zTotal;
    NSLog(@"accx: %f accy: %f accz: %f total: %f",xTotal,yTotal,zTotal,total);
    if (total>shakeThreshold) {
        hello.text = @"SUCCESS!!";
    }else{
        hello.text = @"Failure!!";
    }
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
