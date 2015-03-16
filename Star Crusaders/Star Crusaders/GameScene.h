//
//  GameScene.h
//  Star Crusaders
//

//  Copyright (c) 2015 Honest Abe Games. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <CoreMotion/CoreMotion.h>

@interface GameScene : SKScene <SKPhysicsContactDelegate, UIAccelerometerDelegate>


@property CGPoint *shipPosition;

@property SKSpriteNode *sprite;


@property SKSpriteNode *background;

@property CGPoint *backgroundlocation;

@property SKNode *lazers;


@property int *timer;

@property NSMutableArray *enemies;


@property (strong, nonatomic) CMMotionManager *motionManager;


@end
