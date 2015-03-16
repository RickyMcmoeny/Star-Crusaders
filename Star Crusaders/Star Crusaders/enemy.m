//
//  enemy.m
//  Star Crusaders
//
//  Created by Dave on 2/27/15.
//  Copyright (c) 2015 Honest Abe Games. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "enemy.h"
#include <stdlib.h>

@implementation Enemy


-(void)changeDirection{
    int r = arc4random() % 2;
    self.direction = r; // 0: straight, 1: left, 2: right
}

-(void)changeStage{
    if (self.stage == 0) {
        self.stage = 1;
    }
}


@end