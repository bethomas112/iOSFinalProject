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
        initializeScene()
    }
    
    func initializeScene() {
        /* Setup your scene here */
        
        var gameScore = PFObject(className:"GameScore")
        gameScore["score"] = 2
        gameScore["playerName"] = "Bill Nye"
        gameScore.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                println("The Object has been saved")
            } else {
                // There was a problem, check error.description
                println("The Object could not be saved: " + error!.description)
            }
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
//        for touch: AnyObject in touches {
//            let location = (touch as! UITouch).locationInNode(self)
//            if let theName = self.nodeAtPoint(location).name {
//                if theName == "swapSceneButton" {
//                    self.removeAllChildren()
//                    if (!swapScene!()) {
//                        initializeScene()
//                    }
//                    else {
//                        
//                    }
//                }
//            }
//        }
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
 }
