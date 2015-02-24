//
//  GameScene.m
//  Star Crusaders
//
//  Created by Dave on 2/23/15.
//  Copyright (c) 2015 Honest Abe Games. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
   
    self.sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
    
    CGPoint location = CGPointMake(525,40);
    
    self.sprite.position = location;
    self.sprite.xScale = 0.1;
    self.sprite.yScale = 0.1;
    
    [self addChild:self.sprite];
    
}
     
     

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    
    
   for (UITouch *touch in touches) {
        CGPoint touchedPoint = [touch locationInNode:self];
       
       CGPoint newLocation = CGPointMake(touchedPoint.x, 40);
       
        //SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        //[sprite runAction:[SKAction repeatActionForever:action]];
       
       self.sprite.position = newLocation;
       
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
