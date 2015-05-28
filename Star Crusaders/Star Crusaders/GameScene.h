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
@property NSMutableArray *enemyTriggers;

@property  UILabel *label;




@property (strong, nonatomic) CMMotionManager *motionManager;

@property (weak, nonatomic) id <sceneDelegate> delegate;


@end

@protocol sceneDelegate <NSObject>
-(void)showDifferentView;
@end


