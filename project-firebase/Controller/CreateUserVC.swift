//
//  CreateUserVC.swift
//  project-firebase
//
//  Created by Ivo Vošahlík on 02/12/2018.
//  Copyright © 2018 Ivo Vošahlík. All rights reserved.
//

import UIKit

class CreateUserVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var email_tf: UITextField!
    @IBOutlet weak var password_tf: UITextField!
    @IBOutlet weak var username_tf: UITextField!
    
    @IBOutlet weak var createUserBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUserBtn.layer.cornerRadius = 10
        cancelBtn.layer.cornerRadius = 10
    }
    
    @IBAction func createUserAction(_ sender: Any) {
        
    }
    
    @IBAction func cancelActon(_ sender: Any) {
    }
    

}
