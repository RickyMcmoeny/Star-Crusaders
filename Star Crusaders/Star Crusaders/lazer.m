//
//  lazer.m
//  Star Crusaders
//
//  Created by Dave on 3/2/15.
//  Copyright (c) 2015 Honest Abe Games. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "lazer.h"

@implementation lazer

- (void)sayHello { //this can be called when the object is made
    NSLog(@"Hello, World!");
    NSLog(@"I was born: ");
    NSLog(@"%d",self.yearOfBirth);
}


-(void)setInteger : (int) year {
    self.yearOfBirth = year;
}


- (void)setLocation : (CGPoint) point {
    self.lazerLocation = &(point);
    NSLog(@"test");
}

@end