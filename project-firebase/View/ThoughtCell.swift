//
//  ThoughtCell.swift
//  project-firebase
//
//  Created by Ivo Vošahlík on 25/11/2018.
//  Copyright © 2018 Ivo Vošahlík. All rights reserved.
//

import UIKit

class ThoughtCell: UITableViewCell {
    
    // Outputs
    @IBOutlet weak var username_label: UILabel!
    @IBOutlet weak var text_label: UILabel!
    @IBOutlet weak var timestamp_label: UILabel!
    @IBOutlet weak var likes_image: UIImageView!
    @IBOutlet weak var likesNum_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(thought: Thought) {
        username_label.text = thought.username
        text_label.text = thought.text
        likesNum_label.text = String(thought.numLikes)
    
    }

}
