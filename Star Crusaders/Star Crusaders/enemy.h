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
- (void)sayHello;
- (void)setInteger:(int)year;

@property (readonly) NSString *firstName; //variables that can be set
@property (readonly) NSString *lastName;
@property int yearOfBirth;



@end


#endif
