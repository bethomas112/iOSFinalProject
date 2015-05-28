//
//  GameScene.swift
//  FinalProject
//
//  Created by Brady Thomas on 5/13/15.
//  Copyright (c) 2015 Brady Thomas. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene {
    
    /*Accerometer Movement*/
    let moveSpeed: CGFloat = 500.0
    var ship = SKSpriteNode()
    var motionManager = CMMotionManager()
    var destX:CGFloat = 0.0
    var destY:CGFloat = 0.0
    
    /*Background*/
    var background: SKNode!;
    let background_speed = 100.0;
    
    /*Time Values*/
    var delta = NSTimeInterval(0);
    var last_update_time = NSTimeInterval(0);
    
    var swapScene : (() -> Bool)?
    
    override func didMoveToView(view: SKView) {
        initializeScene()
    }
    
    func initializeScene() {
        initBackground()
        initAccelerometer()
    }
    
    func initBackground() {
        background = SKNode();
        addChild(background);
        
        for i in 0...2 {
            let tile = SKSpriteNode(imageNamed: "background");
            tile.anchorPoint = CGPointZero
            tile.position = CGPoint(x: 0.0, y: CGFloat(i) * 568)
            tile.name = "bg"
            tile.zPosition = 1
            background.addChild(tile)
        }
    }
    
    func moveBackground() {
        let posY = -background_speed * delta;
        background.position = CGPoint(x: 0.0, y: background.position.y + CGFloat(posY));
        
        background.enumerateChildNodesWithName("bg") { (node, stop) in
            let background_screen_position = self.background.convertPoint(node.position, toNode: self);
            
            let difference = self.frame.height - node.frame.size.height
            
            if background_screen_position.y <= -node.frame.size.height {
//            if background_screen_position.y <= -node.frame.size.height + difference {
                node.position = CGPoint(x: node.position.x, y: node.position.y + (node.frame.size.height * 2));
            }
            
        }
    }
        
    func initAccelerometer() {
        self.size = self.view!.frame.size
        let demo = SKLabelNode(fontNamed:"AppleSDGothicNeo-Regular")
        demo.text = "Accelerometer Demo";
        demo.fontSize = 30;
        demo.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 225)
        self.addChild(demo)
        
        let button = SKShapeNode(rectOfSize: CGSize(width: 150.0, height: 40.0))
        button.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 150)
        button.fillColor = UIColor.grayColor()
        button.name = "swapSceneButton"
        
        let buttonLabel = SKLabelNode(fontNamed: "AppleSDGothicNeo-Regular")
        buttonLabel.text = "ParseDemo"
        buttonLabel.fontSize = 20;
        buttonLabel.color = UIColor.greenColor()
        //buttonLabel.position = button.position
        button.addChild(buttonLabel)
        self.addChild(button)
        
        ship = SKSpriteNode(imageNamed:"Spaceship")
        motionManager = CMMotionManager()
        ship.xScale = 0.3
        ship.yScale = 0.3
        ship.zPosition = 2
        ship.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2 - 250)
        self.addChild(ship)
        // motionManager.accelerometerUpdateInterval = NSTimeInterval(0.05)
        
        if motionManager.accelerometerAvailable {
            
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler:{
                data, error in
                
                var currentX = self.ship.position.x
                var currentY = self.ship.position.y
                
                // 3
                if data.acceleration.x < -0.015 {
                    self.destX = currentX + CGFloat(data.acceleration.x * 800)
                }
                    
                else if data.acceleration.x > 0.015 {
                    self.destX = currentX + CGFloat(data.acceleration.x * 800)
                }
                else {
                    self.destX = currentX
                }
                
            })
        }

    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        for touch: AnyObject in touches {
            let location = (touch as! UITouch).locationInNode(self)
            if let theName = self.nodeAtPoint(location).name {
                if theName == "swapSceneButton" {
                    self.removeAllChildren()
                    if (!swapScene!()) {
                        initializeScene()
                    }
                }
            }
        }
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        delta = (last_update_time == 0.0) ? 0.0 : currentTime - last_update_time;
        last_update_time = currentTime;
        
        moveBackground()
        
        var action = SKAction.moveToX(destX, duration: NSTimeInterval(0.5))
        ship.runAction(action)
    }
}
