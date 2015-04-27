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
{
    NSTimeInterval _lastUpdateTime;
    NSTimeInterval _dt;
    CGPoint _velocity;
    CGPoint _backgroundpoint;
    int _timerOne;
    int _timerTwo;
    int _enemyNumber;
    int _shootingEnemyNumber;
    int _reloadTimer;
    
    int _shootyTimer;
    bool _loadedLaser;
    

}
static const int enemyHitCategory = 1;
static const int enemyLazerHitCategory = 69;
static const int lazerHitCategory = 420;
static const int PlayerHitCategory = 88;




-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    self.timer69 = 50;
    
    //self.motionManager = [[CMMotionManager alloc] init];
    //[self.motionManager startAccelerometerUpdates];
    [[UIAccelerometer sharedAccelerometer]setDelegate:self];
    


   
    self.sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
    self.background = [SKSpriteNode spriteNodeWithImageNamed:@"background"];
    
    _backgroundpoint = CGPointMake(525, 0);
    self.background.position = _backgroundpoint;
    
    SKAction *backgroundScroll = [SKAction moveByX:0.0 y:-10 duration:.01];
    SKAction *keepScrolling = [SKAction repeatActionForever: backgroundScroll];
    
    [self addChild:self.background];
    [self.background runAction:keepScrolling];
    
    self.lazers = [SKSpriteNode spriteNodeWithImageNamed:@"lazer"];

    
    CGPoint location = CGPointMake(525,40);
    self.sprite.name = @"Ship";

    self.sprite.position = location;
    self.sprite.xScale = 0.05;
    self.sprite.yScale = 0.05;
    
    self.sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50, 50)];
    self.sprite.physicsBody.affectedByGravity = false;
    self.sprite.physicsBody.categoryBitMask = PlayerHitCategory;
    self.sprite.physicsBody.contactTestBitMask = lazerHitCategory;
    self.sprite.physicsBody.collisionBitMask =  lazerHitCategory;
    
    
    SKAction *shiftUpSlightly = [SKAction moveByX:0.0 y:5 duration:.5];
    SKAction *shiftDownSlightly = [SKAction moveByX:0.0 y:-5 duration:.5];
    SKAction *shiftySlightly = [SKAction sequence:@[shiftUpSlightly, shiftDownSlightly]];
    SKAction *keepShiftingSlightly = [SKAction repeatActionForever: shiftySlightly];
    [self.sprite runAction:keepShiftingSlightly];
    
    //self.lazer.position = location;
    
    [self addChild:self.sprite];
    
    self.timer = 60;
    _enemyNumber = 0;
    
    
    int rows = 6;
    int columns = 8;
    int startY = 450;
    int startX = 350;
    
    for (int y = 0; y < rows; y++) {
        //make row
        
        for (int x = 0; x < columns; x++) {
            //make a ship
            
            [self createEnemy:(startY+50*y) withX:(startX+50*x)];
            
        }
        
        
        
    }
    
    [self createShootingEnemy:720 withX:525];
    
    

    
    
    if (self)
    {
        self.physicsWorld.gravity = CGVectorMake(0,0);
        self.physicsWorld.contactDelegate = self;
        //self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    }
}


-(void)enemyShoot: (int) posy withX : (int) posx : (NSString*) name {
    
    SKSpriteNode *enemyLaze = [SKSpriteNode spriteNodeWithImageNamed:@"enemyLazer"];
    enemyLaze.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(20, 80)];
    enemyLaze.physicsBody.affectedByGravity = false;
    enemyLaze.physicsBody.categoryBitMask = enemyLazerHitCategory;
    enemyLaze.physicsBody.contactTestBitMask = enemyHitCategory;
    enemyLaze.physicsBody.collisionBitMask =  enemyHitCategory;
    enemyLaze.xScale = .15;
    enemyLaze.yScale = .15;
    
    enemyLaze.name = @"Laser";
    enemyLaze.position = [self childNodeWithName: name].position;
    SKAction *moveNodeDown = [SKAction moveByX:0.0 y:-250 duration:1];
    SKAction *keepMoving = [SKAction repeatActionForever: moveNodeDown];
    
    [enemyLaze runAction: keepMoving];
    [self addChild: enemyLaze];
    
    
}

-(void)createEnemy: (int) posy withX : (int) posx{
    
    Enemy *spaceyOK = [[Enemy alloc] init]; //initalize the class object
    NSString *name = @"enemy";
    
    NSString *idnum = [NSString stringWithFormat:@"%d", _enemyNumber];
    _enemyNumber++;
    name = [name stringByAppendingString:idnum];
    spaceyOK.name = name;
    spaceyOK.stage = 0;

    NSLog(name);
    
    SKSpriteNode *enemy = [SKSpriteNode spriteNodeWithImageNamed:@"enemy2"];

    enemy.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:80];
    enemy.physicsBody.affectedByGravity = false;
    enemy.physicsBody.categoryBitMask = enemyHitCategory;
    enemy.physicsBody.contactTestBitMask = lazerHitCategory;
    enemy.physicsBody.collisionBitMask =  lazerHitCategory;
    
    CGPoint location2 = CGPointMake(posx,posy);
    enemy.name = name;
    enemy.position = location2;
    enemy.xScale = 0.03;
    enemy.yScale = 0.03;
    enemy.zRotation = M_PI/1.0;
    
    SKAction *shiftUp = [SKAction moveByX:0.0 y:20 duration:.5];
    SKAction *shiftDown = [SKAction moveByX:0.0 y:-20 duration:.5];
    SKAction *shifty = [SKAction sequence:@[shiftUp, shiftDown]];
    SKAction *keepShifting = [SKAction repeatActionForever: shifty];
    [enemy runAction:keepShifting];
    
    [self addChild:enemy];
    [self.enemies addObject:spaceyOK];
    int randint = arc4random()%800;
    [self.enemyTimers addObject:[NSNumber numberWithInt:randint]];
    [self.enemyTriggers addObject:[NSNumber numberWithInt:1]];

} //Implicit conversion of 'int' to 'id' is disallowed with ARC

-(void)createShootingEnemy: (int) posy withX : (int) posx{
    
    
    Enemy *spaceyOK = [[Enemy alloc] init]; //initalize the class object
    NSString *name = @"shootingEnemy";
    
    NSString *idnum = [NSString stringWithFormat:@"%d", _shootingEnemyNumber];
    _shootingEnemyNumber++;
    name = [name stringByAppendingString:idnum];
    spaceyOK.name = name;
    spaceyOK.stage = 0;
    
    NSLog(name);
    
    SKSpriteNode *enemy = [SKSpriteNode spriteNodeWithImageNamed:@"enemy1"];
    
    enemy.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:80];
    enemy.physicsBody.affectedByGravity = false;
    enemy.physicsBody.categoryBitMask = enemyHitCategory;
    enemy.physicsBody.contactTestBitMask = lazerHitCategory;
    enemy.physicsBody.collisionBitMask =  lazerHitCategory;
    
    CGPoint location2 = CGPointMake(posx,posy);
    enemy.name = name;
    enemy.position = location2;
    enemy.xScale = 0.03;
    enemy.yScale = 0.03;
    enemy.zRotation = M_PI/1.0;
    
    SKAction *strafeLeftOnce = [SKAction moveByX:-252.5 y:0 duration:2];
    
    SKAction *strafeRight = [SKAction moveByX:450 y:0 duration:4];
    SKAction *strafeLeft = [SKAction moveByX:-450 y:0 duration:4];
    SKAction *strafy = [SKAction sequence:@[strafeRight, strafeLeft]];
    SKAction *keepStrafing = [SKAction repeatActionForever: strafy];
    SKAction *superStrafe = [SKAction sequence:@[strafeLeftOnce, keepStrafing]];

    [enemy runAction:superStrafe];
    
    
    [self addChild:enemy];
    [self.shootingEnemies addObject:spaceyOK];

    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"touch registered");
    
    if (_loadedLaser == true) {
    
    
        SKSpriteNode *laze = [SKSpriteNode spriteNodeWithImageNamed:@"lazer"];
        laze.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(20, 80)];
        laze.physicsBody.affectedByGravity = false;
        laze.physicsBody.categoryBitMask = lazerHitCategory;
        laze.physicsBody.contactTestBitMask = enemyHitCategory;
        laze.physicsBody.collisionBitMask =  enemyHitCategory;
        laze.xScale = .15;
        laze.yScale = .15;
        
        laze.name = @"Laser";
        
        CGPoint lazerspawn = self.sprite.position;
        //lazerspawn.y = lazerspawn.y + 70;
        
        //CGPointMake(525, 0);
        
        
        laze.position = lazerspawn;
        
        SKAction *moveNodeUp = [SKAction moveByX:0.0 y:250 duration:1];
        SKAction *keepMoving = [SKAction repeatActionForever: moveNodeUp];
        
        
        [self addChild: laze];
        
        [laze runAction: keepMoving];
        //[laze runAction: keepRotating];
        _loadedLaser = false;

    }
    
    
    
    
}





-(void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody, *secondBody;
    
    firstBody = contact.bodyA;
    secondBody = contact.bodyB;
    
    //NSLog(@"contact");
    
    if(firstBody.categoryBitMask == lazerHitCategory || secondBody.categoryBitMask == lazerHitCategory)
    {
        
        
        NSLog(@"ping one");

        
        SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"explosion.png"];
        ball.xScale = .2;
        ball.yScale = .2;
        ball.name = @"Explosion";
        ball.position = contact.bodyB.node.position;
        
        SKAction *fadeAway = [SKAction fadeOutWithDuration:.5];
        SKAction *removeNode = [SKAction removeFromParent];
        SKAction *sequence = [SKAction sequence:@[fadeAway, removeNode]];
        
        [ball runAction:sequence];
        [self addChild:ball];
        
        [firstBody.node removeFromParent];
        [secondBody.node removeFromParent];

        
        
        //setup your methods and other things here
        
    }
    
    if ((firstBody.categoryBitMask == PlayerHitCategory && secondBody.categoryBitMask == enemyLazerHitCategory)||(firstBody.categoryBitMask == enemyLazerHitCategory && secondBody.categoryBitMask == PlayerHitCategory))
    {
        NSLog(@"Ping two");
        
        SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"explosion.png"];
        ball.xScale = .2;
        ball.yScale = .2;
        ball.name = @"Explosion";
        ball.position = contact.bodyB.node.position;
        
        SKAction *fadeAway = [SKAction fadeOutWithDuration:.5];
        SKAction *removeNode = [SKAction removeFromParent];
        SKAction *sequence = [SKAction sequence:@[fadeAway, removeNode]];
        
        [ball runAction:sequence];
        [self addChild:ball];
        
        [firstBody.node removeFromParent];
        [secondBody.node removeFromParent];
        
        _reloadTimer = 50000;
        _loadedLaser = false;
        //setup your methods and other things here
        
        
    }
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:
(UIAcceleration *)acceleration{
    
    SKAction *moveNodeX = [SKAction moveByX:(acceleration.x)*100 y:0.0 duration:.1];

   // NSLog(@"%f",acceleration.x);
   // NSLog(@"%f",self.sprite.position.x);
    if (acceleration.x > 0  && self.sprite.position.x < 690) {
        [self.sprite runAction: moveNodeX];
    }
    
    else if (acceleration.x < 0  && self.sprite.position.x > 350) {
        [self.sprite runAction: moveNodeX];
    }

    

}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    SKAction *moveNodeUp = [SKAction moveByX:0.0 y:1 duration:0];
    //[self.lazer runAction: moveNodeUp];
    
    [self.lazers runAction: moveNodeUp];
    
    
    if (_timerOne <= 0) {
        NSLog(@"EnemyWave");
        //[self createEnemy: 3 withX:5];
        
        for (int y = 0; y < (sizeof self.enemies)-1; y++) {
            if (arc4random()%15 == 1) {
                [[self.enemies objectAtIndex:y]changeStage];
            }
        }
        
        _timerOne = 300;
    }
    else
    {
        _timerOne -= 1;
    }
    
    
    if (self.timer <= 0) {
        //NSLog(@"Background Shift");
        
        self.timer = 60;
        
        SKAction *attackAction;
        
        for (int y = 0; y < (sizeof self.enemies)-1; y++) {  //make enemies attacking move
            Enemy *thisenemy = [self.enemies objectAtIndex:y];
            
            if (thisenemy.stage == 1) {
                if (thisenemy.direction == 0) {
                    attackAction = [SKAction moveByX:0 y:50.0 duration:2];
                }
                else if (thisenemy.direction == 1)
                {
                    attackAction = [SKAction moveByX:-10.0 y:0.0 duration:2];
                }
                else
                {
                    attackAction = [SKAction moveByX:10.0 y:0.0 duration:2];
                }
                
                [[self childNodeWithName:thisenemy.name]runAction:attackAction];
            }
        }
        
        
        //CGPoint top = CGPointMake(0,400);

        self.background.position = _backgroundpoint;
    }
    else
    {
        self.timer -= 1;

    }

    //remove any nodes named "yourNode" that make it off screen
    [self enumerateChildNodesWithName:@"yourNode" usingBlock:^(SKNode *node, BOOL *stop) {
        
        if (node.position.y < 0){
            [node removeFromParent];
        }
    }];

    
    if (_shootyTimer <= 0) {
        NSLog(@"enemyshoot");
        //[self createEnemy: 3 withX:5];
        
        
        
        for (int i = 0; i < _enemyNumber; i++) {
            if ([self.enemyTriggers objectAtIndex:i] == 1) {
                
            
                NSString *name = @"enemy";
            
                NSString *idnum = [NSString stringWithFormat:@"%d", i];
            
                name = [name stringByAppendingString:idnum];
            
                SKAction *fallDown = [SKAction moveByX:0 y:-100 duration:4];
            
                SKAction *strafeRight = [SKAction moveByX:50 y:0 duration:4];
                SKAction *strafeLeft = [SKAction moveByX:-50 y:0 duration:4];
                SKAction *strafy = [SKAction sequence:@[strafeRight, strafeLeft]];
                SKAction *keepStrafing = [SKAction repeatActionForever: strafy];
                //SKAction *superStrafe = [SKAction sequence:@[strafeLeftOnce, keepStrafing]];
            
                [[self childNodeWithName:name] runAction:keepStrafing];
                [[self childNodeWithName:name] runAction:fallDown];

            
                [self enemyShoot:[self childNodeWithName: name].position.y withX:[self childNodeWithName: name].position.x:name];
            }
            else
            {
                int randint = arc4random()%100;
                
                if (randint >= 80) {
                    [self.enemyTriggers replaceObjectAtIndex:i withObject: [NSNumber numberWithInt:1]];
                }
            }
        }
        
        for (int i = 0; i < _shootingEnemyNumber; i++) {
            
            NSString *name = @"shootingEnemy";
            
            NSString *idnum = [NSString stringWithFormat:@"%d", i];
            
            name = [name stringByAppendingString:idnum];
            
            [self enemyShoot:[self childNodeWithName: name].position.y withX:[self childNodeWithName: name].position.x:name];
        }
        
        _shootyTimer = 200;
    }
    else
    {
        _shootyTimer -= 1;
    }
    
    
    if (_reloadTimer <= 0) {
        NSLog(@"reload");
        //[self createEnemy: 3 withX:5];
        
        _loadedLaser = true;
        
        _reloadTimer = 20;
    }
    else if (_loadedLaser == false)
    {
        _reloadTimer -= 1;
    }
    
    for (int y = 0; y < (sizeof self.enemyTimers)-1; y++) {  //make enemies attacking move
        if ([self.enemyTimers objectAtIndex:y] <= 0) {
            //trigger ship attack
            NSString *name = [self.enemies objectAtIndex:y];
            //[[self childNodeWithName:name]removeFromParent];
            int firstValue = [[self.enemyTimers objectAtIndex:y] intValue];
            [self.enemyTimers replaceObjectAtIndex:y withObject:[NSNumber numberWithInt:firstValue+600]];

        }
        else
        {
            int firstValue = [[self.enemyTimers objectAtIndex:y] intValue];
            [self.enemyTimers replaceObjectAtIndex:y withObject:[NSNumber numberWithInt:firstValue-1]];
        }
    }
    
    
    

}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.physicsWorld.contactDelegate = self;
        
    }
    return self;
}

@end
