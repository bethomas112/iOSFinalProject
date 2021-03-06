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

    var gameScene: GameScene?
    var scoreScene: ScoreScene?
    var highScoreScene = HighScoreScene()
    var scoreManager = ScoreManager()
    var skView: SKView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        skView = self.view as? SKView
        
        if let scene = ScoreScene.unarchiveFromFile("ScoreScene") as? ScoreScene {
            skView!.ignoresSiblingOrder = true
            scene.scaleMode = .AspectFill
            scene.switchToHighScores = switchToHighScoreView
            scene.restartGame = switchToGameView
            scene.scoreManager = scoreManager
            scoreScene = scene
        }
        
        highScoreScene.scaleMode = .AspectFill
        highScoreScene.restartGame = switchToGameView
        highScoreScene.scoreManager = scoreManager
        
        switchToGameView()
        //switchtoScoreView(15)
        //switchToHighScoreView()
        //switchToParseView()
        
    }
    
    internal func switchtoScoreView(score: Int) -> Bool {
        if let scene = scoreScene {
            scene.playerScore = score
            skView!.presentScene(scene)
            return true
        }
        return false
    }
    
    internal func switchToHighScoreView() -> Bool {
        skView!.presentScene(highScoreScene)
        return true
    }
    
    internal func switchToGameView() -> Bool {
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view.
            
            skView!.showsFPS = false
            skView!.showsNodeCount = false
            skView!.showsPhysics = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView!.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            scene.swapScene = switchToParseView
            skView!.presentScene(scene)
            
            return true
        }
        return false

    }
    
    internal func switchToParseView(score : Int) -> Bool{
        
        return switchtoScoreView(score)
        
        /*if let scene = GameOverScene.unarchiveFromFile("GameOverScene") as? GameOverScene {
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
        }*/
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
