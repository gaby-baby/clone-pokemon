//
//  ViewController.h
//  viewSwapping
//
//  Created by Gabriel A Lau on 2016-03-27.
//  Copyright © 2016 Gabriel A Lau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "MonsterAnimate.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface ViewController : UIViewController


@end

