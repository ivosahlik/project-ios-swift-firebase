//
//  CreateUserVC.swift
//  project-firebase
//
//  Created by Ivo Vošahlík on 02/12/2018.
//  Copyright © 2018 Ivo Vošahlík. All rights reserved.
//

import UIKit
import Firebase

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
        guard let email = email_tf.text,
              let password = password_tf.text,
              let username = username_tf.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                debugPrint("Error creating user: \(error.localizedDescription)")
            }
            
            let changeRequest =  Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = username
            changeRequest?.commitChanges { (error) in
                if let error = error {
                    debugPrint(error.localizedDescription)
                }
            }
            guard let userId = Auth.auth().currentUser?.uid else { return }
            Firestore.firestore().collection(USERS_REF).document(userId).setData(
                [
                    USERNAME: username,
                    DATE_CREATED: FieldValue.serverTimestamp()
                ], completion: { (error) in
                    if let error = error {
                        debugPrint(error.localizedDescription)
                    } else {
                        self.dismiss(animated: true, completion: nil)
                    }
            })
        }
        
    }
    
    @IBAction func cancelActon(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
