//
//  Thought.swift
//  project-firebase
//
//  Created by Ivo Vošahlík on 25/11/2018.
//  Copyright © 2018 Ivo Vošahlík. All rights reserved.
//

import Foundation

class Thought {
    
    private var username: String
    private var timestamp: Date
    private var text: String
    private var numLikes: Int
    private var numComments: Int
    private var documentId: String
    
    init(username: String, timestamp: Date, text: String, numLikes: Int, numComments: Int, documentId:  String) {
        self.username = username
        self.timestamp = timestamp
        self.text = text
        self.numLikes = numLikes
        self.numComments = numComments
        self.documentId = documentId
    }
    
    
}
