//
//  lazer.h
//  Star Crusaders
//
//  Created by Dave on 3/2/15.
//  Copyright (c) 2015 Honest Abe Games. All rights reserved.
//

#ifndef Star_Crusaders_lazer_h
#define Star_Crusaders_lazer_h

#import <SpriteKit/SpriteKit.h>

@interface lazer : NSObject
- (void)sayHello;
- (void)setInteger:(int)year;
- (void)setLocation:(CGPoint)point;

@property (readonly) NSString *firstName; //variables that can be set
@property (readonly) NSString *lastName;
@property int yearOfBirth;

@property CGPoint *lazerLocation;

@end


#endif
