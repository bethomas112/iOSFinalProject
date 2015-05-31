//
//  ScoreManager.swift
//  FinalProject
//
//  Created by Brady Thomas on 5/30/15.
//  Copyright (c) 2015 Brady Thomas. All rights reserved.
//

import Parse

class ScoreManager {
    private var playerScore : Int = 0
    private var def = NSUserDefaults.standardUserDefaults()
    private var parseObjectID : String = ""
    var playerUserName : String = ""
    
    
    init() {
        loadLocalObjectID()
        
        println(playerUserName)
        println(parseObjectID)
        println(playerScore)
    }
    
    
    func updatePlayerScore(userName: String, score: Int) {
        if (userName != playerUserName) {
            let gameScore = PFObject(className: "GameScore")
            gameScore["score"] = score
            gameScore["playerName"] = userName
            gameScore.saveInBackgroundWithBlock {
                [unowned self]
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    self.playerUserName = userName
                    self.parseObjectID = gameScore.objectId!
                    self.playerScore = score
                    self.storeLocalObjectID()
                } else {
                    // There was a problem, check error.description
                }
            }
        }
        else if (score > playerScore) {
            println("Should be in here ")
            var query = PFQuery(className: "GameScore")
            query.getObjectInBackgroundWithId(parseObjectID) {
                [unowned self]
                (gameScore: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    println(error)
                } else if let gameScore = gameScore {
                    gameScore["score"] = score
                    gameScore.saveInBackground()
                    self.playerScore = score
                    self.storeLocalObjectID()
                }
            }
        }
    }
    
    
    private func loadLocalObjectID() {
        if let userObjectID = def.valueForKey("UserObjectID") as? String {
            parseObjectID = userObjectID
        }
        if let userName = def.valueForKey("UserName") as? String {
            playerUserName = userName
        }
        if let score = def.valueForKey("UserScore") as? Int {
            playerScore = score
        }
    }
    
    private func storeLocalObjectID() {
        if (parseObjectID != "") {
            def.setObject(parseObjectID, forKey: "UserObjectID")
        }
        
        if (playerUserName != "") {
            def.setObject(playerUserName, forKey: "UserName")
        }
        def.setObject(playerScore, forKey: "UserScore")
    }
    
}