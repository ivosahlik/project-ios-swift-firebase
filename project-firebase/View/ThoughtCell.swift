//
//  ThoughtCell.swift
//  project-firebase
//
//  Created by Ivo Vošahlík on 25/11/2018.
//  Copyright © 2018 Ivo Vošahlík. All rights reserved.
//

import UIKit
import Firebase

class ThoughtCell: UITableViewCell {
    
    // Outputs
    @IBOutlet weak var username_label: UILabel!
    @IBOutlet weak var text_label: UILabel!
    @IBOutlet weak var timestamp_label: UILabel!
    @IBOutlet weak var likes_image: UIImageView!
    @IBOutlet weak var likesNum_label: UILabel!
    
    // Variables
    private var thought: Thought!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        likes_image.addGestureRecognizer(tap)
        likes_image.isUserInteractionEnabled = true
    }
    
    @objc func likeTapped() {
        Firestore.firestore().collection(TESTDB_REF).document(thought.documentId)
            .setData([NUM_LIKES : thought.numLikes + 1], merge: true)
    }
    
    func configureCell(thought: Thought) {
        self.thought = thought
        username_label.text = thought.username
        text_label.text = thought.text
        likesNum_label.text = String(thought.numLikes)
        timestamp_label.text = getTimestampFormat(thought: thought, format: "MMM d, hh:mm")
    }
    
    /*
     This method return timestamp format
     param: Thought
     param: String
    */
    func getTimestampFormat(thought: Thought, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: thought.timestamp)
    }

}
