//
//  SettingScene.m
//  CattyGo
//
//  Created by Weiling Xi on 08/08/2017.
//  Copyright © 2017 Weiling Xi. All rights reserved.
//

#import "SettingScene.h"
#import "StartScene.h"

@implementation SettingScene

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        
        if([node.name isEqualToString:@"homeButton"]){
            
            SKView *skView = (SKView *)self.view;
            
            StartScene *scene = (StartScene *)[SKScene nodeWithFileNamed:@"StartScene"];
            
            scene.scaleMode = SKSceneScaleModeAspectFit;
            
            [skView presentScene:scene];
            
        }
    }
    
}

@end
