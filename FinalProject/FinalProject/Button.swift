//
//  Button.swift
//  FinalProject
//
//  Created by Brady Thomas on 5/29/15.
//  Copyright (c) 2015 Brady Thomas. All rights reserved.
//

import SpriteKit

class Button: SKNode {
    
    var buttonBody : SKShapeNode?
    var label : SKLabelNode?
    var size: CGSize = CGSize(width: 150.0, height: 40.0)
    var pressedButtonColor : UIColor = UIColor.lightGrayColor()
    var pressCallBack : (() -> ())?
    var callOnPress : Bool = false
    var callOnRelease : Bool = true
    
    /* Properties with getters and setters to update button*/
    var buttonColor : UIColor = UIColor.grayColor() {
        willSet(newButtonColor) {
            
        }
        didSet(newButtonColor) {
            if let b = buttonBody {
                b.fillColor = newButtonColor
            }
        }
    }
    
    var textColor : UIColor = UIColor.blackColor() {
        willSet(newTextColor) {
            
        }
        didSet(newTextColor) {
            if let lb = label {
                lb.color = newTextColor
            }
        }
    }
    
    var text : String = "" {
        willSet(newText) {
            
        }
        didSet(newText) {
            if let lb = label {
                lb.text = newText
            }
        }
    }
    
    /* Initializers */
    convenience init(rectSize: CGSize) {
        self.init()
        
        size = rectSize
        let button = SKShapeNode(rectOfSize: size)
        button.fillColor = UIColor.grayColor()
        button.zPosition = 3
        
        let buttonLabel = SKLabelNode(fontNamed: "AppleSDGothicNeo-Regular")
        buttonLabel.text = "ParseDemo"
        buttonLabel.fontSize = 20;
        buttonLabel.color = UIColor.greenColor()
        buttonLabel.zPosition - 3
        button.addChild(buttonLabel)
    }
    
    convenience init(rectSize: CGSize, font: String) {
        self.init()
        
        size = rectSize
        let button = SKShapeNode(rectOfSize: size)
        button.fillColor = UIColor.grayColor()
        button.zPosition = 3
        
        let buttonLabel = SKLabelNode(fontNamed: font)
        buttonLabel.text = "ParseDemo"
        buttonLabel.fontSize = 20;
        buttonLabel.color = UIColor.greenColor()
        buttonLabel.zPosition - 3
        button.addChild(buttonLabel)
    }
   
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let b = buttonBody {
            b.fillColor = pressedButtonColor
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let b = buttonBody {
            b.fillColor = buttonColor
        }
    }
    
}
