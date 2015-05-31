//
//  ScoreScene.swift
//  FinalProject
//
//  Created by Brady Thomas on 5/29/15.
//  Copyright (c) 2015 Brady Thomas. All rights reserved.
//

import SpriteKit

class ScoreScene: SKScene {
    /* Has the scene been initialized */
    private var initialized: Bool = false
    
    var scoreManager : ScoreManager = ScoreManager()
    
    /* The most recent player score */
    var playerScore: Int = 0
    
    /* Text Field to enter players name */
    var playerNameField: UITextField?
    
    /* The buttons */
    var submitButton = Button(rectSize: CGSize(width: 200, height: 40))
    var restartButton = Button(rectSize: CGSize(width: 200, height: 40))
    var highScoreButton = Button(rectSize: CGSize(width: 200, height: 40))
    
    override func didMoveToView(view: SKView) {
        if (!initialized) {
            initScene()
        }
        
    }
    
    func initTextField() {
        var loc = self.view!.center
        loc.y -= 200
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
        if (scoreManager.playerUserName != "") {
            textField.text = scoreManager.playerUserName
        }
    }
    
    func submitPlayerInfo(userName : String) {
        scoreManager.updatePlayerScore(userName, score: playerScore)
    }
    
    func submitButtonHandeler() {
        if let userText = playerNameField?.text {
            if (userText != "") {
                print("User text is \(userText)")
                submitButton.removeFromParent()
                self.addChild(restartButton)
                self.addChild(highScoreButton)
                playerNameField!.removeFromSuperview()
                submitPlayerInfo(userText)
            }
        }
    }
    
    func restartButtonHandeler() {
        
    }
    
    func highScoreButtonHandeler() {
        
    }
    
    func initButtons() {
        submitButton.pressCallBack = submitButtonHandeler
        submitButton.text = "Submit Score"
        submitButton.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        restartButton.pressCallBack = restartButtonHandeler
        restartButton.text = "Restart"
        restartButton.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        highScoreButton.pressCallBack = highScoreButtonHandeler
        highScoreButton.text = "High Scores"
        highScoreButton.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 70)
        self.addChild(submitButton)
    }
    
    func initScene() {
        self.size = self.view!.frame.size
        initTextField()
        initButtons()
        self.backgroundColor = UIColor.blackColor()
        initialized = true
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        view!.endEditing(true)
    }
    
    
}
