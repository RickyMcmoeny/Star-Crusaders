//
//  ViewController.m
//  AccelerometerTest
//
//  Created by Jacob Bunker on 3/15/15.
//  Copyright (c) 2015 Jacob Bunker. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIAccelerometer sharedAccelerometer]setDelegate:self];
    //Do any additional setup after loading the view,typically from a nib    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:
(UIAcceleration *)acceleration{
    [self.xlabel setText:[NSString stringWithFormat:@"%f",acceleration.x]];
    [self.ylabel setText:[NSString stringWithFormat:@"%f",acceleration.y]];
    [self.zlabel setText:[NSString stringWithFormat:@"%f",acceleration.z]];
}

@end
