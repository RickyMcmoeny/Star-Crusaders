//
//  GameScene.h
//  Star Crusaders
//

//  Copyright (c) 2015 Honest Abe Games. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <CoreMotion/CoreMotion.h>

@interface GameScene : SKScene <SKPhysicsContactDelegate>


@property CGPoint *shipPosition;

@property SKSpriteNode *sprite;

@property SKSpriteNode *enemy;

@property SKSpriteNode *background;

@property CGPoint *backgroundlocation;

@property SKNode *lazers;


@property int *timer;

//@property (strong, nonatomic) NSMutableArray *lazers;


@property (strong, nonatomic) CMMotionManager *motionManager;


@end
