//
//  GameOverScene.swift
//  FinalProject
//
//  Created by Erik Owen on 5/13/15.
//  Copyright (c) 2015 Brady Thomas. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    init(size: CGSize, score:Int) {
        
        super.init(size: size)
        
//        let nodeSpacing = self.size.height / 15;
        
        backgroundColor = SKColor.blackColor();
        
//        let bgImage = SKSpriteNode(imageNamed: "game_over_background.jpg");
//        bgImage.position = CGPointMake(self.size.width / 2, self.size.height / 2);
//        addChild(bgImage);
//        
//        let scoreLabel = SKLabelNode(fontNamed: "DamascusSemiBold");
//        scoreLabel.text = "Your score was " + String(score) + "!";
//        scoreLabel.fontSize = 25;
//        scoreLabel.fontColor = SKColor.blackColor();
//        scoreLabel.position = CGPoint(x: size.width / 2, y: size.height - nodeSpacing * 2);
//        addChild(scoreLabel);
//        
//        let playAgainLabel = SKLabelNode(fontNamed: "DamascusSemiBold");
//        playAgainLabel.text = "Tap Screen To Play Again";
//        playAgainLabel.fontSize = 20;
//        playAgainLabel.fontColor = SKColor.greenColor();
//        playAgainLabel.position = CGPoint(x: size.width / 2, y: size.height - nodeSpacing * 14);
//        playAgainLabel.name = "restartButton";
//        addChild(playAgainLabel);
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
//        super.touchesEnded(touches, withEvent: event);
//        
//        let restartGameAction = SKAction.runBlock() {
//            let reveal = SKTransition.flipHorizontalWithDuration(0.5);
//            let restartGameScene = GameScene(size: self.size);
//            self.view?.presentScene(restartGameScene, transition: reveal);
//        }
//        
//        runAction(restartGameAction);
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
