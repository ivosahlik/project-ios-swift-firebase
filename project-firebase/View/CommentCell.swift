//
//  CommentCell.swift
//  project-firebase
//
//  Created by Ivo Vošahlík on 04/12/2018.
//  Copyright © 2018 Ivo Vošahlík. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var username_text: UILabel!
    @IBOutlet weak var timestamp_text: UILabel!
    @IBOutlet weak var comment_txt: UILabel!
    
    
    // Variables

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
