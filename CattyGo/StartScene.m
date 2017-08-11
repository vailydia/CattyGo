//
//  StartScene.m
//  CattyGo
//
//  Created by Weiling Xi on 08/08/2017.
//  Copyright © 2017 Weiling Xi. All rights reserved.
//

#import "StartScene.h"
#import "GameScene.h"
#import "SettingScene.h"

@implementation StartScene

- (void)didMoveToView:(SKView *)view {
    
    self.name = @"Fence";
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    
    SKSpriteNode *bg = (SKSpriteNode *)[self childNodeWithName:@"bg_start"];
    bg.zPosition = 0;
    
    SKSpriteNode *settingButton = (SKSpriteNode *)[self childNodeWithName:@"settingButton"];
    settingButton.zPosition = 2;

    SKSpriteNode *loginButton = (SKSpriteNode *)[self childNodeWithName:@"loginButton"];
    loginButton.zPosition = 2;
    
    SKSpriteNode *startButton = (SKSpriteNode *)[self childNodeWithName:@"startButton"];
    startButton.zPosition = 2;
    
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        
        if([node.name isEqualToString:@"settingButton"]){
            
            SKView *skView = (SKView *)self.view;
            
            SettingScene *scene = (SettingScene *)[SKScene nodeWithFileNamed:@"SettingScene"];
            
            scene.scaleMode = SKSceneScaleModeAspectFit;
            
            [skView presentScene:scene];
            
        }else if([node.name isEqualToString:@"loginButton"]){
            
            //login scene ...
            
            
        }else if([node.name isEqualToString:@"startButton"]){
            
            SKView *skView = (SKView *)self.view;
            
            GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];
            
            scene.scaleMode = SKSceneScaleModeAspectFit;
            
            [skView presentScene:scene];
            
        }
        
    }
    
}



@end
