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
    @IBOutlet weak var optionMenu: UIImageView!
    
    // Variables

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(comment: Comment) {
        username_text.text = comment.username
        comment_txt.text = comment.commentTxt
        
        let formater = DateFormatter()
        formater.dateFormat = "MMM d, hh:mm"
        let timestamp = formater.string(from: comment.timestamp)
        timestamp_text.text = timestamp
    }
}
