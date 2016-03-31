//
//  ViewController.m
//  viewSwapping
//
//  Created by Gabriel A Lau on 2016-03-27.
//  Copyright © 2016 Gabriel A Lau. All rights reserved.
//

#import "ViewController.h"
#import "MonsterAnimate.h"

@interface ViewController()
@property (weak, nonatomic) IBOutlet UIButton *goButton;


@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0x009ECE);
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startAnimation{
    // Configure the view.
    
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [MonsterAnimate sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [self.goButton setHidden:TRUE];
    // Present the scene.
    [skView presentScene:scene];
}

@end
