//
//  GameScene.m
//  Star Crusaders
//
//  Created by Dave on 2/23/15.
//  Copyright (c) 2015 Honest Abe Games. All rights reserved.
//

#import "GameScene.h"
#import "enemy.h"

@implementation GameScene
static const int enemyHitCategory = 1;
static const int lazerHitCategory = 2;

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    Enemy *spaceyOK = [[Enemy alloc] init]; //initalize the class object
    [spaceyOK setInteger:10];
    [spaceyOK sayHello]; //call a method inside the class: print "helloworld"

   
    self.sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
    self.enemy = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];

    self.lazers = [SKSpriteNode spriteNodeWithImageNamed:@"lazer"];

    
    //self.lazer = [SKSpriteNode spriteNodeWithImageNamed:@"lazer"];
    
    self.enemy.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:80];
    self.enemy.physicsBody.affectedByGravity = false;
    self.enemy.physicsBody.categoryBitMask = enemyHitCategory;
    self.enemy.physicsBody.contactTestBitMask = lazerHitCategory;
    self.enemy.physicsBody.collisionBitMask =  lazerHitCategory;
    
    CGPoint location2 = CGPointMake(525,560);
    self.enemy.name = @"bugship";
    self.enemy.position = location2;
    self.enemy.xScale = 0.05;
    self.enemy.yScale = 0.05;
    self.enemy.zRotation = M_PI/1.0;
    [self addChild:self.enemy];
    
    SKAction *moveNodeDown = [SKAction moveByX:0.0 y:-1 duration:1];
    SKAction *keepMovingDown = [SKAction repeatActionForever: moveNodeDown];
    

    
    [self.enemy runAction: keepMovingDown];
    

    
    CGPoint location = CGPointMake(525,40);
    self.sprite.name = @"Ship";

    self.sprite.position = location;
    self.sprite.xScale = 0.1;
    self.sprite.yScale = 0.1;
    
    //self.lazer.position = location;
    
    [self addChild:self.sprite];
    
    self.timer = 300;
    
}
     




-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    
    
   for (UITouch *touch in touches) {
       
       CGPoint touchedPoint = [touch locationInNode:self];
       
       CGPoint newLocation = CGPointMake(touchedPoint.x, 40);
       
        //SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        //[sprite runAction:[SKAction repeatActionForever:action]];
       
       self.sprite.position = newLocation;
       
       if (touchedPoint.y > 120) {
           NSLog(@"touch registered");
           
           SKSpriteNode *laze = [SKSpriteNode spriteNodeWithImageNamed:@"lazer"];
           laze.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(20, 80)];
           laze.physicsBody.affectedByGravity = false;
           laze.physicsBody.categoryBitMask = lazerHitCategory;
           laze.physicsBody.contactTestBitMask = enemyHitCategory;
           laze.physicsBody.collisionBitMask =  enemyHitCategory;
           
           laze.name = @"Laser";
           laze.position = newLocation;
           SKAction *moveNodeUp = [SKAction moveByX:0.0 y:250 duration:1];
           SKAction *keepMoving = [SKAction repeatActionForever: moveNodeUp];

           [self addChild: laze];
           
           [laze runAction: keepMoving];
           


           
       }
       
    }
}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody, *secondBody;
    
    firstBody = contact.bodyA;
    secondBody = contact.bodyB;
    
    if(firstBody.categoryBitMask == lazerHitCategory || secondBody.categoryBitMask == lazerHitCategory)
    {
        
        NSLog(@"balloon hit the spikes");
        //setup your methods and other things here
        
    }
}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    SKAction *moveNodeUp = [SKAction moveByX:0.0 y:1 duration:0];
    //[self.lazer runAction: moveNodeUp];
    
    [self.lazers runAction: moveNodeUp];
    
    
    if (self.timer <= 0) {
        NSLog(@"Spawn Enemy");
        self.timer = 500;
    }
    else
    {
        self.timer -= 1;

    }

    
    
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.physicsWorld.contactDelegate = self;
        
    }
    return self;
}

@end
