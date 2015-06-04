//
//  GameScene.swift
//  FinalProject
//
//  Created by Brady Thomas on 5/13/15.
//  Copyright (c) 2015 Brady Thomas. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    /*Accerometer Movement*/
    let moveSpeed: CGFloat = 500.0
    var player = SKSpriteNode()
    var motionManager = CMMotionManager()
    var destX:CGFloat = 0.0
    var destY:CGFloat = 0.0
    
    /*Background*/
    var background: SKNode!
    let background_speed = 250.0
    
    /*Time Values*/
    var delta = NSTimeInterval(0)
    var last_update_time = NSTimeInterval(0)
    
    /*Physics categories*/
    let FSBoundaryCategory: UInt32 = 1 << 0
    let FSPlayerCategory: UInt32 = 1 << 1
    let FSObstacleCategory: UInt32 = 1 << 2
    
    var swapScene : (() -> Bool)?
    
    func skRandf() -> CGFloat {
        return CGFloat(Double(arc4random()) / Double(UINT32_MAX))
    }
    
    func skRand(lowerBound low: CGFloat, upperBound high: CGFloat) -> CGFloat {
        return skRandf() * (high - low) + low
    }
    
    override func didMoveToView(view: SKView) {
        initializeScene()
    }
    
    func initializeScene() {
        initCar()
        initButtons()
        initBackground()
        initWorld()
        initObstacles()
    }
    
    func initWorld() {
        let wallWidth : CGFloat = self.size.width / 12.0
        
        physicsWorld.contactDelegate = self
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x: wallWidth, y: 0.0, width: self.size.width - (self.size.width / 6.0), height: self.size.height))
        self.physicsBody?.friction = 0.0
        self.physicsBody?.categoryBitMask = FSBoundaryCategory
        self.physicsBody?.collisionBitMask = FSPlayerCategory | FSObstacleCategory
        self.physicsBody?.contactTestBitMask = FSPlayerCategory | FSObstacleCategory
    }
    
    func initBackground() {
        background = SKNode();
        addChild(background);
        
        for i in 0...3 {
            let tile = SKSpriteNode(imageNamed: "background");
            tile.anchorPoint = CGPointZero
            tile.position = CGPoint(x: 0.0, y: CGFloat(i) * tile.size.height)
            tile.name = "bg"
            tile.size.width = self.size.width
            tile.zPosition = 1
            background.addChild(tile)
        }
    }
    
    func moveBackground() {
        let posY = -background_speed * delta;
        background.position = CGPoint(x: 0.0, y: background.position.y + CGFloat(posY));
        
        background.enumerateChildNodesWithName("bg") { (node, stop) in
            let background_screen_position = self.background.convertPoint(node.position, toNode: self);
            
            if background_screen_position.y <= -node.frame.size.height {
                node.position = CGPoint(x: node.position.x, y: node.position.y + (node.frame.size.height * 3));
            }
            
        }
    }
        
    func initCar() {
        player = SKSpriteNode(imageNamed:"player_car")
        motionManager = CMMotionManager()
        player.xScale = 0.3
        player.yScale = 0.3
        player.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: player.size.width * 0.5, height: player.size.height))
        player.physicsBody?.categoryBitMask = FSPlayerCategory
        player.physicsBody?.contactTestBitMask = FSBoundaryCategory | FSObstacleCategory
        player.physicsBody?.collisionBitMask = FSBoundaryCategory | FSObstacleCategory
        player.physicsBody?.affectedByGravity = false;
        player.physicsBody?.allowsRotation = false;
        player.physicsBody?.restitution = 0.9
        player.physicsBody?.dynamic = true
        player.zPosition = 4
        player.position = CGPoint(x: 200, y: self.size.height / 6)
        self.destX = player.position.x
        
        self.addChild(player)
        
        if motionManager.accelerometerAvailable {
            
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler:{
                data, error in
                
                var currentX = self.player.position.x
                var currentY = self.player.position.y
                
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
    
    func initObstacles() {
        let addObstacle = SKAction.sequence([
            SKAction.runBlock {
                self.addObstacle("obstacle1")
            },
            SKAction.waitForDuration(2.0, withRange: 0.5)
            ])
        
        let addObstacles = SKAction.repeatActionForever(addObstacle)
        
        runAction(addObstacles)
    }
    
    func addObstacle(fileName: String) {
        let obstacle = SKSpriteNode(imageNamed: fileName)
        obstacle.position = CGPoint(x: skRand(lowerBound: self.size.width / 12.0, upperBound: self.size.width - (self.size.width / 12.0)), y: self.size.height)
        obstacle.name = "obstacle"
        obstacle.zPosition = 4
        
        let physicsBody = SKPhysicsBody(circleOfRadius: obstacle.size.width / 2.0)
        physicsBody.affectedByGravity = false
        physicsBody.velocity = CGVector(dx: 0, dy: -100)
        physicsBody.categoryBitMask = FSObstacleCategory
        physicsBody.contactTestBitMask = FSPlayerCategory | FSBoundaryCategory
        physicsBody.collisionBitMask = FSPlayerCategory | FSBoundaryCategory
        obstacle.physicsBody = physicsBody
        
        self.addChild(obstacle)
    }
    
    func initButtons() {
        self.size = self.view!.frame.size
        let demo = SKLabelNode(fontNamed:"AppleSDGothicNeo-Regular")
        demo.text = "Accelerometer Demo";
        demo.fontSize = 30;
        demo.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 225)
        demo.zPosition = 3
        self.addChild(demo)
        
        let button = SKShapeNode(rectOfSize: CGSize(width: 150.0, height: 40.0))
        button.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 150)
        button.fillColor = UIColor.grayColor()
        button.name = "swapSceneButton"
        button.zPosition = 3
        
        let buttonLabel = SKLabelNode(fontNamed: "AppleSDGothicNeo-Regular")
        buttonLabel.text = "ParseDemo"
        buttonLabel.fontSize = 20;
        buttonLabel.color = UIColor.greenColor()
        buttonLabel.zPosition - 3
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
                    if (!swapScene!()) {
                        initializeScene()
                    }
                }
            }
        }
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        let collision: UInt32 = (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask);
        
//        if(collision == (FSPlayerCategory | FSBoundaryCategory)) {
//            player.position.x = player.position.x
//        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        delta = (last_update_time == 0.0) ? 0.0 : currentTime - last_update_time;
        last_update_time = currentTime;
        
        moveBackground()
        
        if (destX > self.size.width - (self.size.width / 12.0)) {
            destX = self.size.width - (self.size.width / 12.0)
        }
        if (destX < self.size.width / 12.0) {
            destX = self.size.width / 12.0
        }
        
        var action = SKAction.moveToX(destX, duration: NSTimeInterval(0.1))
        player.runAction(action)
    }
}
