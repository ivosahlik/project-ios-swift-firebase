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
    private(set) var userId: String
    
    init(username: String, timestamp: Date, text: String, numLikes: Int, numComments: Int, documentId:  String, userId: String) {
        self.username = username
        self.timestamp = timestamp
        self.text = text
        self.numLikes = numLikes
        self.numComments = numComments
        self.documentId = documentId
        self.userId = userId
    }
    
    // QuerySnapshot from Firebase import
    class func parseData(snapshot: QuerySnapshot?) -> [Thought] {
        var thoughts = [Thought]()
        
        guard let snap = snapshot else {return thoughts}
        for document in snap.documents {
            let data = document.data()
            
            let username = data[USERNAME] as? String ?? ANONYMOUS
            let text = data[TEXT] as? String ?? ""
            let timestamp = data[TIMESTAMP] as? Date ?? Date()
            let numLikes = data[NUM_LIKES] as? Int ?? 0
            
            let numCommments = data[NUM_COMMENTS]! as! Int
            
            let documentId = document.documentID
            let userId = data[USER_ID] as? String ?? ""
            
            let newThought = Thought(username: username, timestamp: timestamp, text: text, numLikes: numLikes, numComments: numCommments, documentId: documentId, userId: userId)
            thoughts.append(newThought)
        }
        
        return thoughts
    }
    
    
}
