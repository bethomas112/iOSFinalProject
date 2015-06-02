//
//  Button.swift
//  FinalProject
//
//  Created by Brady Thomas on 5/29/15.
//  Copyright (c) 2015 Brady Thomas. All rights reserved.
//

import SpriteKit

class Button: SKNode {
    
    private var buttonBody : SKShapeNode?
    private var label : SKLabelNode?
    var size: CGSize = CGSize(width: 150.0, height: 40.0)
    var pressedButtonColor : UIColor = UIColor.lightGrayColor()
    var pressCallBack : (() -> ())?
    var callOnPress : Bool = false
    
    /* Properties with getters and setters to update button*/
    
    var buttonColor : UIColor = UIColor.grayColor() {
        didSet(newButtonColor) {
            if let b = buttonBody {
                b.fillColor = buttonColor
            }
        }
    }
    
    var fontSize : CGFloat = 20 {
        didSet(newFontSize) {
            if let lb = label {
                lb.fontSize = fontSize
            }
        }
    }
    
    var textColor : UIColor = UIColor.blackColor() {
        didSet(newTextColor) {
            if let lb = label {
                lb.color = textColor
            }
        }
    }
    
    var text : String = "" {
        didSet(newText) {
            if let lb = label {
                lb.text = text
            }
        }
    }
    
    /* Initializers */
    convenience init(rectSize: CGSize) {
        self.init()
        
        size = rectSize
        let button = SKShapeNode(rectOfSize: size)
        button.fillColor = buttonColor
        button.zPosition = 3
        
        let buttonLabel = SKLabelNode(fontNamed: "AppleSDGothicNeo-Regular")
        buttonLabel.text = "New Button"
        buttonLabel.fontSize = fontSize
        buttonLabel.color = textColor
        button.addChild(buttonLabel)
        buttonLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
        buttonLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        
        buttonBody = button
        label = buttonLabel
        self.addChild(buttonBody!)
        self.userInteractionEnabled = true
        
    }
    
    convenience init(rectSize: CGSize, font: String) {
        self.init()
        
        size = rectSize
        let button = SKShapeNode(rectOfSize: size)
        button.fillColor = buttonColor
        button.zPosition = 3
        
        let buttonLabel = SKLabelNode(fontNamed: font)
        buttonLabel.text = "New Button"
        buttonLabel.fontSize = fontSize
        buttonLabel.color = textColor
        button.addChild(buttonLabel)
        buttonLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
        buttonLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        
        buttonBody = button
        label = buttonLabel
        self.addChild(buttonBody!)
        self.userInteractionEnabled = true
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
        
        if (callOnPress) {
            if let callBack = pressCallBack {
                callBack()
            }
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let b = buttonBody {
            b.fillColor = buttonColor
        }
        
        if (!callOnPress) {
            if let callBack = pressCallBack {
                callBack()
            }
        }
    }
    
}
