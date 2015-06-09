//
//  ScoreScene.swift
//  FinalProject
//
//  Created by Brady Thomas on 5/29/15.
//  Copyright (c) 2015 Brady Thomas. All rights reserved.
//

import SpriteKit

class ScoreScene: SKScene {
    private var initialized: Bool = false
    var scoreManager : ScoreManager?
    var playerScore: Int = 0
    
    /* Callbacks */
    var switchToHighScores : (() -> Bool)?
    var restartGame : (() -> Bool)?
    
    /* Text Field */
    var playerNameField: UITextField?
    var textFieldExists : Bool = false
    
    /* Buttons */
    var submitButton = Button(rectSize: CGSize(width: 200, height: 40))
    var restartButton = Button(rectSize: CGSize(width: 200, height: 40))
    var highScoreButton = Button(rectSize: CGSize(width: 200, height: 40))
    
    /* Labels */
    var scoreLabel = SKLabelNode(fontNamed: "AppleSDGothicNeo-Regular")
    var nameLabel = SKLabelNode(fontNamed: "AppleSDGothicNeo-Regular")
    var rankLabel = SKLabelNode(fontNamed: "AppleSDGothicNeo-Regular")
    var playerRankLabel = SKLabelNode(fontNamed: "AppleSDGothicNeo-Regular")
    
    override func didMoveToView(view: SKView) {
        if (!initialized) {
            initScene()
        }
        else {
            reloadScene()
        }
        
    }
    
    func initTextField() {
        var loc = self.view!.center
        loc.y -= 75
        
        let textField = UITextField(frame: CGRect(origin: self.view!.center, size: CGSize(width: 200, height: 40)))
        textField.center = loc
        textField.borderStyle = UITextBorderStyle.RoundedRect;
        textField.textColor = UIColor.blackColor()
        textField.placeholder = "Enter Your Name"
        textField.backgroundColor = UIColor.whiteColor()
        textField.keyboardType = UIKeyboardType.Default
        textField.clearButtonMode = UITextFieldViewMode.WhileEditing
        
        playerNameField = textField
        self.view?.addSubview(playerNameField!)
        textFieldExists = true
        
        if (scoreManager!.playerUserName != "") {
            textField.text = scoreManager!.playerUserName
        }
    }
    
    func reloadScene() {
        self.removeAllChildren()
        //restartButton.removeFromParent()
        //highScoreButton.removeFromParent()
        //rankLabel.removeFromParent()
        //playerRankLabel.removeFromParent()
        
        self.addChild(scoreLabel)
        scoreLabel.text = "Your Score: \(playerScore)"
        
        self.view?.addSubview(playerNameField!)
        textFieldExists = true
        self.addChild(nameLabel)
        self.addChild(restartButton)
        self.addChild(submitButton)
    }
    
    func submitPlayerInfo(userName : String) {
        scoreManager!.updatePlayerScore(userName, score: playerScore)
    }
    
    func submitButtonHandeler() {
        if let userText = playerNameField?.text {
            if (userText != "") {
                submitPlayerInfo(userText)
                var rankString = scoreManager!.getPlayerRankString()
                playerRankLabel.text = rankString
                submitButton.removeFromParent()
                playerNameField!.removeFromSuperview()
                textFieldExists = false
                nameLabel.removeFromParent()
                
                self.addChild(rankLabel)
                //self.addChild(restartButton)
                self.addChild(highScoreButton)
                self.addChild(playerRankLabel)
                if (rankString == "") {
                    restartButtonHandeler()
                }
                
            }
        }
    }
    
    func restartButtonHandeler() {
        if (textFieldExists) {
            playerNameField!.removeFromSuperview()
            textFieldExists = false
        }
        restartGame!()
    }
    
    func highScoreButtonHandeler() {
        switchToHighScores!()
    }
    
    func initButtons() {
        submitButton.pressCallBack = submitButtonHandeler
        submitButton.text = "Submit Score"
        submitButton.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 15)
        
        restartButton.pressCallBack = restartButtonHandeler
        restartButton.text = "Restart"
        restartButton.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - 45)
        
        highScoreButton.pressCallBack = highScoreButtonHandeler
        highScoreButton.text = "High Scores"
        highScoreButton.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 10)
        self.addChild(submitButton)
        self.addChild(restartButton)
    }
    
    func initLabels() {
        scoreLabel.text = "Your Score: \(playerScore)"
        scoreLabel.fontSize = 45
        scoreLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 215)
        
        nameLabel.text = "Enter your name"
        nameLabel.fontSize = 25
        nameLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 110)
        
        rankLabel.text = "Your Top Rank:"
        rankLabel.fontSize = 35
        rankLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 140)
        
        playerRankLabel.text = "4 out of 10"
        playerRankLabel.fontSize = 30
        playerRankLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 80)
        
        self.addChild(scoreLabel)
        self.addChild(nameLabel)
    }
    
    func initScene() {
        self.size = self.view!.frame.size
        initTextField()
        initButtons()
        initLabels()
        self.backgroundColor = UIColor.blackColor()
        initialized = true
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        view!.endEditing(true)
    }
    
    
}
