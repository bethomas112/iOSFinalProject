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
        
    }
    
    func getTopScores() -> [String] {
        var query = PFQuery(className: "GameScore")
        query.orderByDescending("score")
        query.limit = 3
        let scores = query.findObjects()
        
        var topScores : [String] = []
        
        if let objects = scores as? [PFObject] {
            for (idx, object) in enumerate(objects) {
                var playerName = object["playerName"] as! String
                var score = object["score"] as! Int
                if (object.objectId == parseObjectID) {
                    topScores.append("->\(idx + 1). \(playerName) : \(score)")
                }
                else {
                    topScores.append("\(idx + 1). \(playerName) : \(score)")
                }
            }
        }
        return topScores
    }
    
    func calculateSkip() -> Int {
        var rank = getPlayerRank()
        var numScores = getNumScores()
        
        println("Rank is \(rank)")
        
        if (rank - 3) < 0 {
            return 0
        }
        else if (rank + 3) > numScores {
            return numScores - 5
        }
        else {
            return rank - 3
        }
    }
    
    func getSurroundingScores() -> [String] {
        var query = PFQuery(className: "GameScore")
        query.orderByDescending("score")
        query.limit = 5
        query.skip = calculateSkip()
        println("calculated Skip \(query.skip)")
        var surroundingScores : [String] = []
        
        let scores = query.findObjects()
        
        if let objects = scores as? [PFObject] {
            for (idx, object) in enumerate(objects) {
                var name = object["playerName"] as! String
                var score = object["score"] as! Int
                var place = query.skip + idx + 1
                if (object.objectId == parseObjectID) {
                    surroundingScores.append("->\(place). \(name) : \(score)")
                }
                else {
                    surroundingScores.append("\(place). \(name) : \(score)")
                }
                
            }
        }
        return surroundingScores
    }
    
    func getPlayerRank() -> Int {
        var query = PFQuery(className: "GameScore")
        query.orderByDescending("score")
        let scores = query.findObjects()
        println("player objid \(parseObjectID)")
        if let objects = scores as? [PFObject] {
            for (idx, object) in enumerate(objects) {
                if (object.objectId == parseObjectID) {
                    return idx + 1
                }
            }
        }
        return -1
    }
    
    func getNumScores() -> Int {
        var query = PFQuery(className: "GameScore")
        return query.countObjects()
    }
    
    func getPlayerRankString() -> String {
        var totalScores = getNumScores()
        var playerRank = getPlayerRank()
        
        if (playerRank == -1) {
            return ""
        }
        return "\(playerRank) out of \(totalScores)"
    }
    
    func updatePlayerScore(userName: String, score: Int) {
        if (parseObjectID == "") {
            let gameScore = PFObject(className: "GameScore")
            gameScore["score"] = score
            gameScore["playerName"] = userName
            self.playerUserName = userName
            self.playerScore = score
            if (gameScore.save()) {
                self.parseObjectID = gameScore.objectId!
                self.storeLocalObjectID()
            }
        }
        else if (score > playerScore) {
            var query = PFQuery(className: "GameScore")
            query.getObjectInBackgroundWithId(parseObjectID) {
                [unowned self]
                (gameScore: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    println(error)
                } else if let gameScore = gameScore {
                    if (userName != self.playerUserName) {
                        self.playerUserName = userName
                        gameScore["playerName"] = self.playerUserName
                    }
                    gameScore["score"] = score
                    gameScore.save()
                    self.playerScore = score
                    self.storeLocalObjectID()
                }
            }
        }
        else if (userName != playerUserName) {
            var query = PFQuery(className: "GameScore")
            query.getObjectInBackgroundWithId(parseObjectID) {
                [unowned self]
                (gameScore: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    println(error)
                } else if let gameScore = gameScore {
                    self.playerUserName = userName
                    gameScore["playerName"] = self.playerUserName
                    gameScore.save()
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