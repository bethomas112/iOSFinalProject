//
//  GameViewController.swift
//  FinalProject
//
//  Created by Brady Thomas on 5/13/15.
//  Copyright (c) 2015 Brady Thomas. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! SKScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {

    var gameOverScene: GameOverScene?
    var accelerometerScene: GameScene?
    var skView: SKView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        skView = self.view as? SKView
        
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view.
            
            skView!.showsFPS = true
            skView!.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView!.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            scene.swapScene = switchToParseView
            accelerometerScene = scene
            
        }
        
        /* Need to init GameOverScene() */
        switchToAccelerometerView()
        
    }
    
    internal func switchToAccelerometerView() -> Bool {
        if let scene = accelerometerScene {
            skView!.presentScene(scene)
            return true
        }
        return false
    }
    
    internal func switchToParseView() -> Bool{
        if let scene = GameOverScene.unarchiveFromFile("GameOverScene") as? GameOverScene {
            // Configure the view.
            
            skView!.showsFPS = false
            skView!.showsNodeCount = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView!.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            scene.swapScene = switchToAccelerometerView
            gameOverScene = scene
            
        }
        println("in switch to parse view")
        if let scene = gameOverScene {
            println("game over scene exists")
            skView!.presentScene(scene)
            return true
        }
        else {
            return false
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
