//
//  GameScene.h
//  Star Crusaders
//

//  Copyright (c) 2015 Honest Abe Games. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <CoreMotion/CoreMotion.h>

@interface GameScene : SKScene

@property CGPoint *shipPosition;

@property SKSpriteNode *sprite;

@property SKSpriteNode *lazer;

//@property NSMutableArray

@property (strong, nonatomic) CMMotionManager *motionManager;


@end
