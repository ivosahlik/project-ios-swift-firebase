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
    @IBOutlet weak var timestamp_label: UILabel!
    @IBOutlet weak var textToughtLabel: UILabel!
    @IBOutlet weak var likesImg: UIImageView!
    @IBOutlet weak var likesNumLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(thought: Thought) {
        
    }

}
