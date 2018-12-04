//
//  CommentsVC.swift
//  project-firebase
//
//  Created by Ivo Vošahlík on 04/12/2018.
//  Copyright © 2018 Ivo Vošahlík. All rights reserved.
//

import UIKit

class CommentsVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCommentText: UITextField!
    @IBOutlet weak var keyboardView: UIView!
    
    
    // Variables
    var thought : Thought!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Action
    @IBAction func addCommentAction(_ sender: Any) {
    }
    

}


