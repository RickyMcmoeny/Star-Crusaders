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

@property int *timer69;

@property NSMutableArray *enemies;

@property NSMutableArray *shootingEnemies;
@property NSMutableArray *enemyTimers;


@property (strong, nonatomic) CMMotionManager *motionManager;



@end
