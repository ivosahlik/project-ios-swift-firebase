//
//  LoginVC.swift
//  project-firebase
//
//  Created by Ivo Vošahlík on 02/12/2018.
//  Copyright © 2018 Ivo Vošahlík. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var email_tf: UITextField!
    @IBOutlet weak var password_tf: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var createUserBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.layer.cornerRadius = 10
        createUserBtn.layer.cornerRadius = 10
    }
    
    @IBAction func loginBtnAction(_ sender: Any) {
        guard let email = email_tf.text,
            let password = password_tf.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                debugPrint("Error signing in: \(error)")
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
}
