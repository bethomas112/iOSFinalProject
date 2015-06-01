//
//  HighScoreScene.swift
//  FinalProject
//
//  Created by Brady Thomas on 5/31/15.
//  Copyright (c) 2015 Brady Thomas. All rights reserved.
//

import SpriteKit

class HighScoreScene: SKScene {
    private var initialized : Bool = false
    private var scoreManager = ScoreManager()
    
    /* Labels */
    var highScoreLabel = SKLabelNode(fontNamed: "AppleSDGothicNeo-Regular")
    var relativeScoreLabel = SKLabelNode(fontNamed: "AppleSDGothicNeo-Regular")
    
    /* Buttons */
    var restartButton = Button(rectSize: CGSize(width: 200, height: 40))
    
    /* Callbacks */
    var restartGame : (() -> Bool)?
    
    
    override func didMoveToView(view: SKView) {
        if (!initialized) {
            initScene()
            initialized = true
        }
        else {
            reloadScene()
        }
        
    }
    
    func addTopScores() {
        let topScores = scoreManager.getTopScores()
        
        for (idx, score) in enumerate(topScores) {
            var label = SKLabelNode(fontNamed: "AppleSDGothicNeo-Regular")
            var offset : CGFloat = 180.0 - (40.0 * CGFloat(idx))
            label.fontSize = 30
            label.text = score
            label.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + offset)
            self.addChild(label)
        }
    }
    
    func addRelativeScores() {
        let relScores = scoreManager.getSurroundingScores()
        
        for (idx, score) in enumerate(relScores) {
            var label = SKLabelNode(fontNamed: "AppleSDGothicNeo-Regular")
            var offset : CGFloat = -25 - (40 * CGFloat(idx))
            label.fontSize = 30
            label.text = score
            label.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + offset)
            self.addChild(label)
        }
    }
    
    func initLabels() {
        highScoreLabel.text = "High Scores"
        highScoreLabel.fontSize = 45
        highScoreLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 240)
        
        relativeScoreLabel.text = "Your rank"
        relativeScoreLabel.fontSize = 45
        relativeScoreLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 30)
        
        self.addChild(highScoreLabel)
        self.addChild(relativeScoreLabel)
        
    }
    
    func restartButtonHandeler() {
        self.removeAllChildren()
        restartGame!()
    }
    
    func initButtons() {
        restartButton.pressCallBack = restartButtonHandeler
        restartButton.text = "Restart"
        restartButton.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - 250)
        self.addChild(restartButton)

    }
    
    func initScene() {
        self.size = self.view!.frame.size
        backgroundColor = UIColor.blackColor()
        initLabels()
        initButtons()
        addTopScores()
        addRelativeScores()
    }
    
    func reloadScene() {
        self.addChild(highScoreLabel)
        self.addChild(restartButton)
        self.addChild(relativeScoreLabel)
        addTopScores()
        addRelativeScores()
    }
}
