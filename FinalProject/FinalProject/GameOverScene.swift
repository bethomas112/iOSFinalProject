//
//  GameOverScene.swift
//  FinalProject
//
//  Created by Erik Owen on 5/13/15.
//  Copyright (c) 2015 Brady Thomas. All rights reserved.
//

import Foundation
import SpriteKit
import Parse

class GameOverScene: SKScene {
    
    var swapScene : (() -> Bool)?
    
    override func didMoveToView(view: SKView) {
        view.frame.height
        initializeScene(view.frame.height / 15)
    }
    
    func initializeScene(nodeSpacing : CGFloat) {
        /* Setup your scene here */
        
        let titleLabel = SKLabelNode(fontNamed: "DamascusSemiBold")
        titleLabel.text = "High Scores: Parse Demo"
        titleLabel.fontSize = 30
        titleLabel.fontColor = SKColor.whiteColor()
        titleLabel.position = CGPoint(x: size.width / 2, y: size.height - nodeSpacing * 2)
        addChild(titleLabel)
        
        var query = PFQuery(className:"GameScore")
//        query.whereKey("playerName", equalTo:"Sean Plott")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        println(object)
                    }
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
        let button = SKShapeNode(rectOfSize: CGSize(width: 200.0, height: 40.0))
        button.position = CGPoint(x: size.width / 2, y: size.height - nodeSpacing * 12)
        button.fillColor = UIColor.grayColor()
        button.name = "swapSceneButton"
        
        let buttonLabel = SKLabelNode(fontNamed: "AppleSDGothicNeo-Regular")
        buttonLabel.text = "Accelerometer Demo"
        buttonLabel.fontSize = 20;
        buttonLabel.color = UIColor.greenColor()
        //buttonLabel.position = button.position
        button.addChild(buttonLabel)
        self.addChild(button)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        for touch: AnyObject in touches {
            let location = (touch as! UITouch).locationInNode(self)
            if let theName = self.nodeAtPoint(location).name {
                if theName == "swapSceneButton" {
                    self.removeAllChildren()
                    
                    swapScene!()
                }
            }
        }
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
 }
