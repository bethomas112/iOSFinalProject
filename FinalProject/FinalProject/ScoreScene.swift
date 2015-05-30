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
    
    /* The most recent player score */
    var playerScore: Int = 0
    
    /* Text Field to enter players name */
    var playerNameField: UITextField?
    
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
    }
    
    func initButtons() {
        
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
