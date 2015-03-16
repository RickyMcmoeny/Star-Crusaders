//
//  enemy.h
//  Star Crusaders
//
//  Created by Dave on 2/27/15.
//  Copyright (c) 2015 Honest Abe Games. All rights reserved.
//

#ifndef Star_Crusaders_enemy_h
#define Star_Crusaders_enemy_h

@interface Enemy : NSObject
//- (void)setStage:(int)stage;
- (void)changeDirection;
- (void)changeStage;



@property NSString *name; //variables that can be set
@property (nonatomic) int stage;

//stage = 0: standby
//stage = 1: attack

@property (nonatomic) int direction;

//direction = 0: straight
//direction = 1: left
//direction = 2: right



@end


#endif
