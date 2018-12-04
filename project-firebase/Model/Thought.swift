//
//  Thought.swift
//  project-firebase
//
//  Created by Ivo Vošahlík on 25/11/2018.
//  Copyright © 2018 Ivo Vošahlík. All rights reserved.
//

import Foundation
import Firebase

class Thought {
    
    private(set) var username: String
    private(set) var timestamp: Date
    private(set) var text: String
    private(set) var numLikes: Int
    private(set) var numComments: Int
    private(set) var documentId: String
    
    init(username: String, timestamp: Date, text: String, numLikes: Int, numComments: Int, documentId:  String) {
        self.username = username
        self.timestamp = timestamp
        self.text = text
        self.numLikes = numLikes
        self.numComments = numComments
        self.documentId = documentId
    }
    
    // QuerySnapshot from Firebase import
    class func parseData(snapshot: QuerySnapshot?) -> [Thought] {
        var thoughts = [Thought]()
        
        guard let snap = snapshot else {return thoughts}
        for document in snap.documents {
            let data = document.data()
            
            let username = data["username"] as? String ?? "Anonymous"
            let text = data["text"] as? String ?? ""
            let timestamp = data["timestamp"] as? Date ?? Date()
            let numLikes = data["numLikes"] as? Int ?? 0
            
            let numCommments = data["numCommments"]! as! Int
            
            let documentId = document.documentID
            
            let newThought = Thought(username: username, timestamp: timestamp, text: text, numLikes: numLikes, numComments: numCommments, documentId: documentId)
            thoughts.append(newThought)
        }
        
        return thoughts
    }
    
    
}
