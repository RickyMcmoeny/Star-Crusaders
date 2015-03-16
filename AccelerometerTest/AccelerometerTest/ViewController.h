//
//  ViewController.h
//  AccelerometerTest
//
//  Created by Jacob Bunker on 3/15/15.
//  Copyright (c) 2015 Jacob Bunker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIAccelerometerDelegate>

    @property IBOutlet UILabel *xlabel;
    @property IBOutlet UILabel *ylabel;
    @property IBOutlet UILabel *zlabel;

@end

