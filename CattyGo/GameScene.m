//
//  GameScene.m
//  CattyGo
//
//  Created by Weiling Xi on 07/08/2017.
//  Copyright © 2017 Weiling Xi. All rights reserved.
//

#import "GameScene.h"
#import "OverScene.h"

@implementation GameScene


- (void)didMoveToView:(SKView *)view {
    
    SKSpriteNode *background = (SKSpriteNode *)[self childNodeWithName:@"background"];
    SKPhysicsBody *borderBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:background.frame];
    self.physicsBody = borderBody;
    self.physicsBody.friction = 1.0f;
    background.zPosition = 0;
    
    

    
    
    //walkAnimation and jumpAnimation
    NSMutableArray<SKTexture *> *textures = [NSMutableArray new];
    
    for(int i=1; i<=10; i++){
        [textures addObject:[SKTexture textureWithImageNamed:[NSString stringWithFormat:@"Walk (%d).png",i]]];
    }
    
    self.walkAnimation = [SKAction repeatActionForever:[SKAction animateWithTextures:textures timePerFrame:0.1]];
    
    textures = [NSMutableArray new];
    
    for(int i=1; i<=8; i++){
        [textures addObject:[SKTexture textureWithImageNamed:[NSString stringWithFormat:@"Jump (%d).png",i]]];
    }
    
    [textures addObject:[SKTexture textureWithImageNamed:[NSString stringWithFormat:@"Walk (1).png"]]];
    self.jumpAnimation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    
    
    
    //set up camera constraints
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    
    
    SKCameraNode *camere = (SKCameraNode *)[self childNodeWithName:@"mainCamera"];
    SKSpriteNode *cat = (SKSpriteNode *)[self childNodeWithName:@"cat"];
    
    id horizConstraint = [SKConstraint distance:[SKRange rangeWithUpperLimit:100] toNode:cat];
    id vertConstraint = [SKConstraint distance:[SKRange rangeWithUpperLimit:50] toNode:cat];
    
    id leftConstraint = [SKConstraint positionX:[SKRange rangeWithLowerLimit:camere.position.x]];
    id bottomConstraint = [SKConstraint positionY:[SKRange rangeWithLowerLimit:camere.position.y]];
    id rightConstraint = [SKConstraint positionX:[SKRange rangeWithUpperLimit:(background.frame.size.width - camere.position.x)]];
    id topConstraint = [SKConstraint positionY:[SKRange rangeWithUpperLimit:(background.frame.size.height - camere.position.y)]];
    
    [camere setConstraints:@[horizConstraint,vertConstraint,leftConstraint,bottomConstraint,topConstraint,rightConstraint]];
    
    
    
    SKSpriteNode *leftMove = (SKSpriteNode *)[self childNodeWithName:@"leftMove"];
    SKSpriteNode *rightMove = (SKSpriteNode *)[self childNodeWithName:@"rightMove"];
    SKSpriteNode *jump = (SKSpriteNode *)[self childNodeWithName:@"jump"];
    SKSpriteNode *stop = (SKSpriteNode *)[self childNodeWithName:@"stopButton"];

    
    //stop
    id horizForStop = [SKConstraint positionX:[SKRange rangeWithConstantValue:screenWidth/2-10]];
    id vertForStop = [SKConstraint positionY:[SKRange rangeWithConstantValue:screenHeight/2-10]];
    
    [horizForStop setReferenceNode:camere];
    [vertForStop setReferenceNode:camere];
    [stop setConstraints:@[horizForStop,vertForStop]];
    
    //jump
    id horizForJump = [SKConstraint positionX:[SKRange rangeWithConstantValue:screenWidth/2-10]];
    id vertForJump = [SKConstraint positionY:[SKRange rangeWithConstantValue:-(screenHeight/2-10)]];
    
    [horizForJump setReferenceNode:camere];
    [vertForJump setReferenceNode:camere];
    [jump setConstraints:@[horizForJump,vertForJump]];
    
    //leftMove
    id horizForLeft = [SKConstraint positionX:[SKRange rangeWithConstantValue:-(screenWidth/2-10)]];
    id vertForLeft = [SKConstraint positionY:[SKRange rangeWithConstantValue:-(screenHeight/2-10)]];
    
    [horizForLeft setReferenceNode:camere];
    [vertForLeft setReferenceNode:camere];
    [leftMove setConstraints:@[horizForLeft,vertForLeft]];
    
    //rightMove
    id horizForRight = [SKConstraint positionX:[SKRange rangeWithConstantValue:-(screenWidth/2-leftMove.frame.size.width-10)]];
    id vertForRight = [SKConstraint positionY:[SKRange rangeWithConstantValue:-(screenHeight/2-10)]];
    
    [horizForRight setReferenceNode:camere];
    [vertForRight setReferenceNode:camere];
    [rightMove setConstraints:@[horizForRight,vertForRight]];
    

}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    static const NSTimeInterval kHugeTime = 9999.0;
    static const int kMoveSpeed = 100;
    
    SKSpriteNode *cat = (SKSpriteNode *)[self childNodeWithName:@"cat"];
    
    for (UITouch *touch in touches) {
        
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        
        if([node.name isEqualToString:@"stopButton"]){
            
            SKView *skView = (SKView *)self.view;
            
            OverScene *scene = (OverScene *)[SKScene nodeWithFileNamed:@"OverScene"];
            
            scene.scaleMode = SKSceneScaleModeAspectFit;
            
            [skView presentScene:scene];
            
        }else if([node.name isEqualToString:@"leftMove"]){
            
            //move left
            SKAction *leftMove = [SKAction moveBy:CGVectorMake((-1.0 * kMoveSpeed * kHugeTime),0) duration:kHugeTime];
            [cat runAction:leftMove withKey:@"Action"];
            [cat runAction:self.walkAnimation];
            
        }else if([node.name isEqualToString:@"rightMove"]){
            
            //move right
            SKAction *rightMove = [SKAction moveBy:CGVectorMake((1.0 * kMoveSpeed * kHugeTime),0) duration:kHugeTime];
            [cat runAction:rightMove withKey:@"Action"];
            [cat runAction:self.walkAnimation];
            
        }else if([node.name isEqualToString:@"jump"]){
            
            //jump
            SKAction *jumpMove = [SKAction applyImpulse:CGVectorMake(0, 1000) duration:0.3];

            [cat runAction:self.jumpAnimation];
            [cat runAction:jumpMove withKey:@"Action"];
            
            
            
            
        }
        
    }
    
    
    
}



//change scene to setting scene
- (void)changeToSettingScene {
    
    
    // Load the SKScene from 'GameScene.sks'
    GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];
    
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    SKView *skView = (SKView *)self.view;
    
    // Present the scene
    [skView presentScene:scene];
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    
}

@end
